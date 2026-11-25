// 后端接口封装。
// 开发环境：Vite 把 /api 代理到 8080；生产环境：Nginx 把 /api 代理到后端。
const BASE = '/api'

async function request(url, options = {}) {
  const res = await fetch(BASE + url, {
    headers: { 'Content-Type': 'application/json' },
    ...options,
  })
  const data = await res.json().catch(() => null)
  if (!res.ok) {
    throw new Error(data?.message || `请求失败（HTTP ${res.status}）`)
  }
  return data
}

export const ping = () => request('/ping')
export const fetchNotes = () => request('/notes')
export const createNote = (content) =>
  request('/notes', { method: 'POST', body: JSON.stringify({ content }) })
export const deleteNote = (id) => request(`/notes/${id}`, { method: 'DELETE' })
