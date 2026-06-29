# AGENTS.md

Delfos es un copiloto personal de finanzas **local-first**: backend Flask (Python, gestionado con `uv`) + frontend Astro/Svelte. Antes de tocar código, lee `docs/00_vision.md` y `docs/01_arquitectura.md` (fuente de verdad) y respeta `.cursor/rules/`.

## Cursor Cloud specific instructions

El update script ya deja instaladas las dependencias (`uv sync` en `backend/`, `npm install` en `frontend/`). `uv` se instala en `~/.local/bin`; si `uv` no se encuentra en el PATH, usa `export PATH="$HOME/.local/bin:$PATH"`.

Servicios y comandos (rutas relativas a la raíz del repo):

| Servicio | Levantar (dev) | Notas |
|----------|----------------|-------|
| Backend API (Flask) | `cd backend && uv run python app.py` | Sirve en `http://127.0.0.1:5000`. `GET /api/finance` debe responder `200`. |
| Frontend (Astro/Svelte) | `cd frontend && npm run dev` | Sirve en `http://localhost:4321`. |

- **Tests:** `cd backend && uv run python -m unittest tests.test_api -v` (también `uv run pytest`). No requieren servicios externos.
- **Build:** `cd frontend && npm run build` → `frontend/dist/` (también valida tipos vía `astro build`). No existe script `lint` dedicado; `astro build` es la verificación de compilación/tipos. `astro check` requiere instalar `@astrojs/check` (no es dependencia del repo).
- **Gotcha (dev frontend → backend):** en dev el frontend (4321) llama al backend (5000) vía CORS. El cliente HTTP usa `import.meta.env.PUBLIC_API_BASE_URL`; sin él las llamadas van al mismo origen (4321) y fallan. Crea `frontend/.env` con `PUBLIC_API_BASE_URL=http://localhost:5000` (gitignored). En Docker/`.exe` se deja vacío para usar rutas relativas `/api`.
- **IA es opcional:** el registro manual, CSV, tests y dashboard funcionan sin proveedor de IA. Ollama/Gemini/OpenRouter no están instalados en este entorno; análisis de texto e OCR fallarán o usarán fallback (nota) sin un proveedor configurado. No bloquees el setup por IA.
- **Persistencia:** datos en `backend/data/*.json` (gitignored). `delfos_data.json` ya trae datos de ejemplo; el reset exige confirmación `"RESTABLECER"`.
