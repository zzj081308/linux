<script setup>
import StatusCard from './components/StatusCard.vue'
import NoteBoard from './components/NoteBoard.vue'
</script>

<template>
  <div class="page">
    <img src="/OIP-C.webp" class="corner-logo" alt="logo" />
    <header class="header">
      <h1>🚀 前后端分离部署练习</h1>
      <p>Vue3 + Spring Boot + MySQL + Redis + Nginx</p>
    </header>

    <main class="container">
      <StatusCard />
      <NoteBoard />
    </main>

    <footer class="footer">
      数据流：浏览器 → Nginx（静态页面 + /api 反向代理）→ Spring Boot → MySQL / Redis
    </footer>
  </div>
</template>

<style>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: 'Segoe UI', 'PingFang SC', 'Microsoft YaHei', sans-serif;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  min-height: 100vh;
  color: #2c3e50;
}

.page {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

/* 右上角小图片 */
.corner-logo {
  position: fixed;
  top: 20px;
  right: 20px;
  width: 56px;
  height: 56px;
  object-fit: cover;
  border-radius: 10px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
  z-index: 10;
}

.header {
  text-align: center;
  padding: 48px 16px 24px;
  color: #fff;
}
.header h1 {
  font-size: 32px;
  margin-bottom: 8px;
}
.header p {
  opacity: 0.85;
}

.container {
  width: min(880px, 100%);
  margin: 0 auto;
  padding: 0 16px 32px;
  display: flex;
  flex-direction: column;
  gap: 20px;
  flex: 1;
}

.card {
  background: #fff;
  border-radius: 12px;
  padding: 20px 24px;
  box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
}
.card-head {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 16px;
}
.card-head h2 {
  font-size: 18px;
}
.hint {
  font-size: 12px;
  color: #9aa5b1;
  margin-left: 8px;
  font-weight: normal;
  font-family: Consolas, monospace;
}

.btn {
  border: 1px solid #d3dae3;
  background: #fff;
  color: #33475b;
  padding: 6px 14px;
  border-radius: 6px;
  cursor: pointer;
  font-size: 13px;
}
.btn:hover:not(:disabled) {
  background: #f0f4f8;
}
.btn.primary {
  background: #667eea;
  border-color: #667eea;
  color: #fff;
}
.btn.primary:hover:not(:disabled) {
  background: #5568d3;
}
.btn:disabled {
  opacity: 0.55;
  cursor: not-allowed;
}

.error {
  color: #d64545;
  background: #fdecec;
  border: 1px solid #f5c6c6;
  padding: 8px 12px;
  border-radius: 6px;
  margin-bottom: 12px;
  font-size: 13px;
}

.footer {
  text-align: center;
  color: rgba(255, 255, 255, 0.75);
  font-size: 12px;
  padding: 16px;
}
</style>
