<script setup>
import { onMounted, ref } from 'vue'
import { ping } from '../api'

const loading = ref(false)
const error = ref('')
const info = ref(null)

async function refresh() {
  loading.value = true
  error.value = ''
  try {
    info.value = await ping()
  } catch (e) {
    error.value = e.message
  } finally {
    loading.value = false
  }
}

onMounted(refresh)
</script>

<template>
  <section class="card">
    <div class="card-head">
      <h2>🩺 系统状态 <span class="hint">GET /api/ping</span></h2>
      <button class="btn" :disabled="loading" @click="refresh">
        {{ loading ? '检测中…' : '重新检测' }}
      </button>
    </div>

    <p v-if="error" class="error">⚠️ 后端连接失败：{{ error }}</p>

    <div v-else-if="info" class="status-grid">
      <div class="status-item">
        <span class="label">后端服务</span>
        <span class="value ok">{{ info.status }}</span>
      </div>
      <div class="status-item">
        <span class="label">Redis</span>
        <span class="value" :class="info.redisOk ? 'ok' : 'bad'">
          {{ info.redisOk ? '已连接 ✔' : '未连接 ✘' }}
        </span>
      </div>
      <div class="status-item">
        <span class="label">累计访问次数（Redis 计数）</span>
        <span class="value">{{ info.visits ?? '—' }}</span>
      </div>
      <div class="status-item">
        <span class="label">服务器时间</span>
        <span class="value">{{ (info.serverTime || '').replace('T', ' ') }}</span>
      </div>
    </div>
  </section>
</template>

<style scoped>
.status-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
  gap: 12px;
}
.status-item {
  background: #f7f9fc;
  border-radius: 8px;
  padding: 12px 14px;
  display: flex;
  flex-direction: column;
  gap: 6px;
}
.label {
  font-size: 12px;
  color: #7b8794;
}
.value {
  font-size: 15px;
  font-weight: 600;
}
.value.ok {
  color: #2e9e5b;
}
.value.bad {
  color: #d64545;
}
</style>
