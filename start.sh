#!/bin/bash
set -e

UUID="${UUID:-d342d11e-d424-4583-b36e-524ab1f0afa4}"
PORT="${PORT:-8080}"
WS_PATH="${WS_PATH:-/}"

echo "[ewp] PORT=${PORT} WS_PATH=${WS_PATH}"

cat > config.json << CFEOF
{
  "log": { "level": "info", "timestamp": true },
  "listener": {
    "port": ${PORT},
    "address": "0.0.0.0",
    "modes": ["ws"],
    "ws_path": "${WS_PATH}"
  },
  "protocol": {
    "type": "ewp",
    "uuid": "${UUID}",
    "enable_flow": false
  },
  "advanced": {
    "padding_min": 100,
    "padding_max": 1000,
    "sse_headers": true
  }
}
CFEOF

echo "[ewp] config.json generated"

chmod +x ./ewp-server
exec ./ewp-server -c config.json
