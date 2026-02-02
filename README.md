# AI-Compliance Real-Time Sentinel

> Plataforma autónoma de AIOps y Seguridad de Endpoints: observabilidad multiplataforma, inteligencia de cumplimiento (Groq/Ollama) y gestión conversacional (ChatOps).

[![CI](https://github.com/maurorosero/ai-compliance-sentinel/actions/workflows/ci.yml/badge.svg)](https://github.com/maurorosero/ai-compliance-sentinel/actions/workflows/ci.yml)

---

## Disclaimer

**Este proyecto nace como un proyecto universitario** para la carrera de **Licenciatura en Desarrollo y Gestión de Software** de la **Facultad de Ingeniería en Sistemas Computacionales** de la **Universidad Tecnológica de Panamá** (Centro Regional de Coclé), en la materia **«Práctica Laboral en Desarrollo de Software»**.

Dicha asignatura es una **colaboración de Cerebro Digital con la universidad**. Parte o la totalidad del proyecto forma parte de la funcionalidad de **[Infraforge](https://github.com/maurorosero/infraforge)**.

Este proyecto, en sí y por sí mismo, **no pretende ser un proyecto final y profesional de uso público**. **Se recomienda no utilizarlo en producción.**

---

## Índice

- [Disclaimer](#disclaimer)
- [Especificación del proyecto](#especificación-del-proyecto)
  - [1. Visión estratégica](#1-visión-estratégica)
  - [2. Descripción funcional y casos de uso](#2-descripción-funcional-y-casos-de-uso)
- [Flujo de ramas (CI/CD)](#flujo-de-ramas-cicd)
- [Reglas de oro](#reglas-de-oro)
- [Estructura del repositorio](#estructura-del-repositorio)
- [Evaluación](#evaluación)
- [Primeros pasos (onboarding)](#primeros-pasos-onboarding)
- [Contribuir](#contribuir)
- [Licencia](#licencia)

---

## Especificación del proyecto

**Especificación de Proyecto: AI-Compliance Real-Time Sentinel (v16.0)**

### 1. Visión estratégica

El **AI-Compliance Real-Time Sentinel** es una plataforma autónoma de AIOps y Seguridad de Endpoints. Su objetivo es gestionar y auditar de forma centralizada una flota heterogénea de activos tecnológicos (servidores Linux y estaciones de trabajo macOS/Windows). El sistema utiliza Inteligencia Artificial para interpretar políticas de cumplimiento, detectar anomalías y permitir una gestión conversacional fluida.

### 2. Descripción funcional y casos de uso

#### A. Observabilidad multiplataforma (Osquery)

Uso de **Osquery** como agente universal para abstraer las diferencias entre sistemas operativos y consultar datos del sistema mediante SQL estándar.

**Caso de uso:** Consultar en toda la flota (Win/Mac/Linux) qué parches de seguridad faltan con una sola pregunta al bot.

#### B. Inteligencia de cumplimiento híbrida (IA)

Un motor que utiliza **Groq** (para velocidad de respuesta) y **Ollama** (para soberanía y privacidad de datos) para contrastar eventos contra el archivo `POLICIES.md`.

**Caso de uso:** Se detecta la instalación de un cliente Torrent; la IA identifica la violación basándose en la política escrita y dispara una alerta inmediata.

#### C. Gestión conversacional (ChatOps)

Interfaz de lenguaje natural (**Text-to-SQL**) para indagar en la flota de manera fluida.

**Caso de uso:** Preguntar: *"¿Cuántas laptops tienen el disco cifrado?"*. La IA genera la query correcta según el SO (`bitlocker_info` para Windows, `disk_encryption` para macOS o `luks_info` para Linux).

---

## Flujo de ramas (CI/CD)

| Rama       | Uso                    |
| ---------- | ---------------------- |
| `develop`  | Integración de desarrollo |
| `testing`  | Preproducción / staging |
| `main`     | Producción (protegida)  |

Flujo: `develop` → `testing` → `main`. Los cambios se integran vía pull requests; las ramas `main` y `testing` requieren que pase el pipeline de CI.

---

## Reglas de oro

- **Zero Manual Touch:** Despliegue 100% automatizado (Ansible/Docker).
- **No Secrets in Code:** Uso obligatorio de variables de entorno o Ansible Vault.
- **Docker Everywhere:** Los servicios (n8n, agentes, DB) deben correr en contenedores en todos los entornos.

---

## Estructura del repositorio

```
.github/workflows/   # Pipelines de CI/CD (GitHub Actions)
├── ci.yml           # Lint, tests y validaciones
```

El archivo **`POLICIES.md`** en la raíz es el contrato de verdad: la IA lo utiliza como base para el razonamiento de cumplimiento.

---

## Evaluación

Cronograma de entregables, criterios de evaluación final (Ingeniería 40%, IA & ChatOps 20%, Metodología 20%, Venta & Demo 20%) y **métricas medibles por semana**: **[Documento de evaluación](docs/EVALUACION.md)**.

---

## Primeros pasos (onboarding)

¿Eres nuevo en el proyecto? Sigue la **[Guía paso a paso para desarrolladores](docs/GUIA_ONBOARDING_DESARROLLADOR.md)** desde crear una cuenta en GitHub hasta hacer tu primer pull request.

---

## Contribuir

Consulta la **[Guía de contribución](CONTRIBUTING.md)** para roles, responsabilidades por semana y criterios de colaboración.

Resumen rápido:

1. Crea una rama desde `develop` (p. ej. `feature/nombre` o `fix/nombre`).
2. Realiza tus cambios y asegúrate de que el CI pase.
3. Abre un pull request hacia `develop` (o `testing`/`main` según el flujo acordado).
4. Respeta las [reglas de oro](#reglas-de-oro) en todo el código y la infraestructura.

---

## Licencia

Este proyecto está bajo la licencia **[Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)](https://creativecommons.org/licenses/by-nc-sa/4.0/)**.

- **Uso no comercial únicamente.** Uso comercial prohibido sin autorización.
- **ShareAlike:** Las obras derivadas deben publicarse bajo la misma licencia.
- **Atribución:** Se debe citar la autoría y enlazar a esta licencia.

Texto completo: [LICENSE](LICENSE).

---

*AI-Compliance Real-Time Sentinel — v16.0*
