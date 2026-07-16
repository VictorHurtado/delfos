#!/usr/bin/env bash
# Update command para Cloud Agents (idempotente).
# Instala deps de frontend/desktop/backend y calienta el cache de Electron.
set -euo pipefail

export PATH="${HOME}/.local/bin:/usr/local/bin:${PATH}"

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

echo "==> Node/npm"
node --version
npm --version

echo "==> uv"
if ! command -v uv >/dev/null 2>&1; then
  echo "ERROR: uv no está en PATH. Revisa .cursor/Dockerfile / snapshot del environment." >&2
  exit 1
fi
uv --version

echo "==> frontend deps"
if [[ -f frontend/package-lock.json ]]; then
  npm --prefix frontend ci
else
  npm --prefix frontend install
fi

echo "==> desktop deps"
if [[ -f desktop/package-lock.json ]]; then
  npm --prefix desktop ci
else
  npm --prefix desktop install
fi

echo "==> backend deps (incl. PyInstaller en group dev)"
(
  cd backend
  uv sync --group dev
)

echo "==> warm Electron binary cache"
npm --prefix desktop exec -- electron --version

echo "==> environment listo (frontend + desktop + uv/backend)"
