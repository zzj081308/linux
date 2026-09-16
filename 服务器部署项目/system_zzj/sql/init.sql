-- ============================================
-- 初始化脚本：在 MySQL 里执行一次即可
-- 本地（Windows）：mysql -uroot -p < init.sql
-- 服务器（Linux）：mysql -uroot -p < init.sql
-- ============================================

-- 1. 建库
CREATE DATABASE IF NOT EXISTS demo_db
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

-- 2. 建专用账号（生产环境建议用独立账号，不要用 root 连业务库）
--    注意：如果你本机的 root 账号没有 CREATE USER 权限，这一步会报
--    "ERROR 1410: You are not allowed to create a user with GRANT"，
--    本机开发直接忽略即可（开发环境用 root 连库）；上服务器后用 root 执行就能成功。
CREATE USER IF NOT EXISTS 'demo_user'@'%' IDENTIFIED BY 'Demo@123456';
GRANT ALL PRIVILEGES ON demo_db.* TO 'demo_user'@'%';
FLUSH PRIVILEGES;

-- 3. 表结构
--    练习项目里 JPA 配置了 ddl-auto=update，应用启动时会自动建表，
--    所以下面这段可以不执行。列出来是为了让你知道表长什么样。
--
-- USE demo_db;
-- CREATE TABLE IF NOT EXISTS note (
--   id         BIGINT AUTO_INCREMENT PRIMARY KEY,
--   content    VARCHAR(500) NOT NULL,
--   created_at DATETIME(6)   NOT NULL
-- ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;
