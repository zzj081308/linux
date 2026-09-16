# 前后端分离部署练习项目

一个刻意保持简单、但覆盖了真实生产部署链路的全栈项目，用来练习部署：

- **前端**：Vue 3 + Vite（构建产物是纯静态文件，交给 Nginx）
- **后端**：Spring Boot 3（打成单个 jar 包运行）
- **数据库**：MySQL（留言数据）
- **缓存**：Redis（访问计数）
- **反向代理**：Nginx（托管前端 + 把 /api 转发给后端）

## 项目结构

```
system_zzj/
├── backend/                 # Spring Boot 后端
│   ├── pom.xml
│   └── src/main/
│       ├── java/com/example/demo/
│       │   ├── DemoApplication.java          # 启动类
│       │   ├── entity/Note.java              # 留言实体（对应 MySQL 表）
│       │   ├── repository/NoteRepository.java
│       │   ├── controller/
│       │   │   ├── NoteController.java       # /api/notes 留言接口
│       │   │   └── SystemController.java     # /api/ping 状态 + Redis 计数
│       │   ├── config/CorsConfig.java        # 开发环境跨域
│       │   └── exception/GlobalExceptionHandler.java
│       └── resources/application.yml         # 配置（全部支持环境变量覆盖）
├── frontend/                # Vue3 前端
│   ├── vite.config.js       # 开发代理 /api -> 8080
│   └── src/
│       ├── App.vue
│       ├── api.js           # 接口调用封装
│       └── components/
│           ├── StatusCard.vue   # 系统状态卡片（Redis 计数）
│           └── NoteBoard.vue    # 留言板（MySQL 数据）
├── sql/init.sql             # 建库 + 建账号
├── deploy/nginx.conf        # Nginx 配置示例（部署阶段用）
└── README.md
```

## 功能

1. `/api/ping`：返回后端状态、服务器时间，并把 Redis 里的访问计数 +1（验证 Redis）
2. `/api/notes`：留言板增删查（验证 MySQL）
3. Redis 连不上时后端自动降级（页面显示"未连接"，其余功能正常），方便本机无 Redis 时调试

## 本地试运行（Windows）

### 1. MySQL

你本机已装 MySQL80（服务名 `MySQL80`，端口 3306）。

先执行建库脚本（用你自己的 root 密码）：

```powershell
cd C:\Users\27891\Desktop\运维\system_zzj
& "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -uroot -p < sql\init.sql
```

如果你的 root 密码不是 `123456`，启动后端前设置环境变量：

```powershell
$env:DB_PASSWORD = "你的密码"
```

### 2. Redis（可选）

本机没装 Redis 也能跑：后端自动降级，页面显示"Redis 未连接"，其余功能正常。

想完整体验，Windows 上可任选其一（推荐留到服务器上装真正的 Linux 版 Redis）：

- 装 [Memurai](https://www.memurai.com/)（Windows 原生 Redis 兼容版）
- 用 WSL / Docker 跑官方 Redis

### 3. 后端

```powershell
cd backend
mvn spring-boot:run

# 或者打成 jar 再跑（和服务器上的方式完全一致）：
# mvn -DskipTests package
# java -jar target/web-demo.jar
```

看到 `Tomcat started on port 8080` 即成功。验证：浏览器打开 http://localhost:8080/api/ping

### 4. 前端

```powershell
cd frontend
npm install
npm run dev
```

浏览器打开 **http://localhost:5173**。

开发模式下 Vite 把 `/api` 代理到后端 8080，整条链路是通的；部署后这个代理由 Nginx 承担。

## 配置项（环境变量）

后端所有配置都能用环境变量覆盖：本地开发用默认值，上服务器只设环境变量，不改代码：

| 环境变量 | 默认值 | 说明 |
| --- | --- | --- |
| `SERVER_PORT` | 8080 | 后端端口 |
| `DB_HOST` | 127.0.0.1 | MySQL 地址 |
| `DB_PORT` | 3306 | MySQL 端口 |
| `DB_NAME` | demo_db | 数据库名 |
| `DB_USER` | root | 数据库账号 |
| `DB_PASSWORD` | 123456 | 数据库密码 |
| `REDIS_HOST` | 127.0.0.1 | Redis 地址 |
| `REDIS_PORT` | 6379 | Redis 端口 |
| `REDIS_PASSWORD` | （空） | Redis 密码 |

## 接口一览

| 方法 | 路径 | 说明 |
| --- | --- | --- |
| GET | /api/ping | 健康检查 + Redis 访问计数 |
| GET | /api/notes | 留言列表 |
| POST | /api/notes | 新增留言 `{ "content": "..." }` |
| DELETE | /api/notes/{id} | 删除留言 |

## 下一步：服务器部署（规划）

三台机器建议这样分工（都在同一内网，互相可访问）：

```
                 ┌──────────────────────────────┐
  用户浏览器 ───▶ │ Ubuntu 24.04 (4C4G)          │
                 │  Nginx：静态页面 + /api 代理  │
                 │  Spring Boot jar（systemd）   │
                 └──────┬──────────────┬────────┘
                        │              │
              ┌─────────▼────┐   ┌─────▼────────┐
              │ CentOS #1     │   │ CentOS #2    │
              │ MySQL 8       │   │ Redis        │
              │ (3C2G)        │   │ (3C2G)       │
              └───────────────┘   └──────────────┘
```

本地验证通过后，再写详细部署文档（MySQL/Redis 安装、systemd 服务、Nginx 配置、防火墙放行）。
