<script setup>
import { onMounted, ref } from 'vue'
import { createNote, deleteNote, fetchNotes } from '../api'

const notes = ref([])
const content = ref('')
const loading = ref(false)
const submitting = ref(false)
const error = ref('')

async function load() {
  loading.value = true
  error.value = ''
  try {
    notes.value = await fetchNotes()
  } catch (e) {
    error.value = e.message
  } finally {
    loading.value = false
  }
}

async function submit() {
  if (!content.value.trim()) return
  submitting.value = true
  error.value = ''
  try {
    await createNote(content.value.trim())
    content.value = ''
    await load()
  } catch (e) {
    error.value = e.message
  } finally {
    submitting.value = false
  }
}

async function remove(id) {
  try {
    await deleteNote(id)
    await load()
  } catch (e) {
    error.value = e.message
  }
}

function formatTime(s) {
  return s ? s.replace('T', ' ').slice(0, 19) : ''
}

onMounted(load)
</script>

<template>
  <section class="card">
    <div class="card-head">
      <h2>📝 留言板 <span class="hint">MySQL 存储</span></h2>
      <button class="btn" :disabled="loading" @click="load">
        {{ loading ? '加载中…' : '刷新列表' }}
      </button>
    </div>

    <form class="note-form" @submit.prevent="submit">
      <input
        v-model="content"
        maxlength="500"
        placeholder="写点什么吧…（会存进 MySQL）"
      />
      <button class="btn primary" type="submit" :disabled="submitting || !content.trim()">
        {{ submitting ? '提交中…' : '发布留言' }}
      </button>
    </form>

    <p v-if="error" class="error">⚠️ {{ error }}</p>

    <ul v-if="notes.length" class="note-list">
      <li v-for="n in notes" :key="n.id">
        <div class="note-content">{{ n.content }}</div>
        <div class="note-meta">
          <span>#{{ n.id }} · {{ formatTime(n.createdAt) }}</span>
          <button class="link-btn" @click="remove(n.id)">删除</button>
        </div>
      </li>
    </ul>
    <p v-else-if="!loading" class="empty">还没有留言，来发第一条吧～</p>
  </section>
</template>

<style scoped>
.note-form {
  display: flex;
  gap: 10px;
  margin-bottom: 16px;
}
.note-form input {
  flex: 1;
  padding: 9px 12px;
  border: 1px solid #d3dae3;
  border-radius: 6px;
  font-size: 14px;
}
.note-form input:focus {
  outline: none;
  border-color: #667eea;
}

.note-list {
  list-style: none;
  display: flex;
  flex-direction: column;
  gap: 10px;
}
.note-list li {
  border: 1px solid #e6ebf2;
  border-radius: 8px;
  padding: 12px 14px;
  background: #fbfcfe;
}
.note-content {
  font-size: 14px;
  line-height: 1.6;
  word-break: break-all;
}
.note-meta {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 8px;
  font-size: 12px;
  color: #9aa5b1;
}
.link-btn {
  background: none;
  border: none;
  color: #d64545;
  cursor: pointer;
  font-size: 12px;
}
.link-btn:hover {
  text-decoration: underline;
}
.empty {
  color: #9aa5b1;
  text-align: center;
  padding: 24px 0;
  font-size: 14px;
}
</style>
