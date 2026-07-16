# AGENTS.md

Instrucciones para agentes que trabajan en Delfos.

## Fuente de verdad

Antes de escribir código, lee:

- `docs/00_vision.md`
- `docs/01_arquitectura.md`

Respeta capas: `backend/app.py` → `services/` → `integrations/`.  
Frontend: features en `frontend/src/features/` + atomic design en `frontend/src/common/`.

## Cursor Cloud specific instructions

### Environment

El environment está versionado en:

- `.cursor/environment.json` — build Docker + update (`install`)
- `.cursor/Dockerfile` — Node 22+, uv, deps Linux para Electron/AppImage
- `.cursor/install.sh` — sync idempotente de `frontend`, `desktop` y `backend`

Tras el boot, esperados en PATH:

- `node` ≥ 22.12
- `npm`
- `uv`
- PyInstaller vía `uv sync --group dev` en `backend/`

### Comandos útiles

Dev desktop (Flask hijo + ventana Electron):

```bash
npm --prefix frontend run build
npm --prefix desktop run dev
```

Empaquetado Linux (AppImage + backend onefile):

```bash
npm --prefix desktop run dist:linux
```

Salidas típicas:

- `desktop/dist/*.AppImage`
- `backend/dist/delfos-backend`

Tests backend:

```bash
cd backend && uv run python -m unittest tests.test_api -v
```

### Notas

- No pongas `dist:linux` en el update/`install`: es lento; solo bajo demanda.
- Si falta `uv`, el build backend falla con mensaje que pide `DELFOS_UV_BIN`.
- AppImage se construye solo en Linux (este environment es Ubuntu).
