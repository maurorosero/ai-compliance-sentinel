# AI-Compliance Real-Time Sentinel

Plataforma autónoma de AIOps y Seguridad de Endpoints: observabilidad multiplataforma (Osquery), inteligencia de cumplimiento (Groq/Ollama) y gestión conversacional (ChatOps).

## Flujo de ramas (CI/CD)

- **`develop`** — Integración de desarrollo.
- **`testing`** — Preproducción / staging.
- **`main`** — Producción (protegida).

Flujo: `develop` → `testing` → `main`.

## Reglas de oro

- **Zero Manual Touch**: Despliegue 100% automatizado.
- **No Secrets in Code**: Variables de entorno o Ansible Vault.
- **Docker Everywhere**: Servicios en contenedores en todos los entornos.
