#!/usr/bin/env bash
set -euo pipefail

echo "=== POS System Setup ==="
echo ""

# 1. Install frontend dependencies and build
echo "[1/3] Building frontend..."
cd frontend
npm install --silent
npm run build
cd ..

# 2. Build and start Docker services
echo "[2/3] Starting Docker services..."
docker compose up -d --build

# 3. Wait for health
echo "[3/3] Waiting for API health..."
for i in $(seq 1 30); do
  if curl -s http://localhost:4000/api/health > /dev/null 2>&1; then
    echo ""
    echo "=== Setup complete! ==="
    echo "  Frontend: http://localhost:8081"
    echo "  API:      http://localhost:4000/api"
    echo "  Login:    admin / admin123"
    echo ""
    exit 0
  fi
  printf "."
  sleep 1
done

echo ""
echo "Timeout waiting for API. Check logs: docker compose logs api"
exit 1
