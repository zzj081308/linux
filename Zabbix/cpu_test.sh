#!/bin/bash
# cpu_test.sh —— 临时 CPU 压测,用来验证 Zabbix 采集和告警
# 用法: ./cpu_test.sh [秒数] [进程数]
#   ./cpu_test.sh            # 默认压满所有核心,持续 180 秒
#   ./cpu_test.sh 300 2      # 只压 2 个核心,持续 300 秒

set -u
DURATION=${1:-180}
WORKERS=${2:-$(nproc)}

echo "开始压测:${WORKERS} 个进程 × ${DURATION} 秒(本机共 $(nproc) 核)"

pids=()
cleanup() {
    for p in "${pids[@]}"; do kill "$p" 2>/dev/null; done
    echo "压测结束,已全部停止"
}
trap cleanup EXIT INT TERM

for _ in $(seq 1 "$WORKERS"); do
    yes > /dev/null &
    pids+=($!)
done

sleep "$DURATION"