import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

// 本地开发时，浏览器请求 /api/** 会由 Vite 转发到后端
// 部署后这个代理由 Nginx 承担（见 deploy/nginx.conf）
export default defineConfig({
  plugins: [vue()],
  server: {
    port: 5173,
    proxy: {
      '/api': {
        target: 'http://127.0.0.1:8080',
        changeOrigin: true,
      },
    },
  },
})
