# Guía rápida de uso (AI Stack + Fleet)

## 📑 Índice

1. [Clonar el proyecto](#1-clonar-el-proyecto)
2. [Seleccionar entorno](#2-seleccionar-entorno-dev--prod--test)
3. [Ajustes preliminares](#3-ajustes-preliminares)
   - [Certificados TLS](#31-certificados-tls-carpeta-certs)
   - [Dominio / IP (FLEET_HOST)](#32-dominio--ip-usada-en-los-certificados-muy-importante)
   - [Credenciales y llaves de seguridad](#33-credenciales-y-llaves-de-seguridad-revisar-antes-de-producción)
4. [Primera ejecución](#4-primera-ejecucion)
5. [Uso normal](#5-uso-normal)

## 🏗 Flujo de ejecución del stack

Para entender el orden de inicialización del sistema (Fleet, fleetctl e instaladores),
consulta el siguiente diagrama de secuencia:

📄 [Diagrama de inicialización](docs/diagramas/stack-init-sequence.md)

## 1) Clonar el proyecto

```bash
git clone <REPO_URL>
```

---

## 2) Seleccionar entorno (dev / prod / test)

Renombra los archivos de ejemplo según el entorno que vas a usar.
Ejemplo (dev):

```bash
cp dev.env.example .env
cp docker-compose.dev.yml docker-compose.yml
```

## 3) Ajustes preliminares

### 3.1) Certificados TLS (carpeta `certs/`)

📌 Sigue las instrucciones del archivo `.md` que está dentro de `certs/`, solo asegurate de generarlos antes de levantar el compose.

---

### 3.2) Dominio / IP usada en los certificados (MUY IMPORTANTE)

**Despues de generar los certificados manualmente, el dominio o ip usado tambien debe especificarse en la variable de entorno ```FLEET_HOST```**

Ese valor será importante porque:

- Será la dirección desde donde podrás acceder a Fleet (UI/API).
- Será la dirección a la que los instaladores generados por Fleet intentarán conectarse (enroll).
- Será la dirección que los endpoints con `osquery` usarán para conectarse al servidor.

---

#### Caso A: Usar `localhost`

Si generas certificados con `localhost`:

✅ Podrás acceder a Fleet desde el mismo servidor fácilmente.  
❌ Pero los endpoints (otras máquinas) **nunca podrán conectarse** a Fleet, porque para ellos `localhost` significa “ellos mismos”.

---

#### Caso B: Usar un dominio o IP real

Si generas certificados con un dominio custom (ej: `fleet.midominio.com`) o con la IP pública del servidor:

✅ El servidor podrá exponer Fleet correctamente.  
✅ Los endpoints podrán conectarse y enrollarse sin problema.

📌 Importante:

- El servidor donde levantes el compose debe resolver ese dominio hacia su propia IP.
- Los endpoints también deben resolver ese dominio hacia la IP actual del servidor.

Esto se puede lograr con:

- DNS público (Cloudflare, etc.)
- o entradas en el archivo `hosts` (solo para pruebas).

---

### 3.3) Credenciales y llaves de seguridad (REVISAR ANTES DE PRODUCCIÓN)

El archivo `.env` contiene múltiples credenciales.  
Algunas pueden mantenerse con valores de ejemplo en entornos de prueba, pero otras **deben cambiarse obligatoriamente en producción**.

---

#### 🔴 CRÍTICO — Deben cambiarse en producción

Estas llaves controlan la seguridad del servidor y de los endpoints:

- `FLEET_SERVER_PRIVATE_KEY`  
  Secreto usado por Fleet para firmar y validar los tokens internos del servidor (API, sesiones y autenticación).

- `FLEET_ENROLL_SECRET`  
  Secreto usado para permitir el registro (enroll) seguro de los endpoints en Fleet.

⚠️ Si estas llaves no se cambian en producción, se compromete la seguridad del entorno.

Genera valores seguros con:

```bash
openssl rand -base64 32
```

---

#### 👤 Administrador inicial de Fleet

Las siguientes variables crean el usuario administrador y la organización inicial:

- `FLEET_ORG_NAME`
- `FLEET_ADMIN_NAME`
- `FLEET_ADMIN_EMAIL`
- `FLEET_ADMIN_PASSWORD`

⚠️ Se recomienda cambiar especialmente `FLEET_ADMIN_PASSWORD` antes de usar en producción.

---

#### 🗄️ Base de datos

Credenciales utilizadas por MySQL y PostgreSQL:

- `MYSQL_ROOT_PASSWORD`
- `MYSQL_USER`
- `MYSQL_PASSWORD`
- `POSTGRES_USER`
- `POSTGRES_PASSWORD`

⚠️ Aunque el entorno puede funcionar con valores por defecto (ej: `admin`, `fleet123`, etc.), no es recomendable utilizarlos en entornos productivos.

## 4) Primera Ejecucion

En la primera ejecución, construye las imágenes:

```bash
docker compose build
 ```

Se levanta el stack, `--profile setup` activará contendores auxiliares para generar los instaladores.

- *Los instaladores se generaran en `instaladores/`*

```bash
docker compose --profile setup up -d
 ```

## 5) Uso normal

### Levantar el stack

```bash
docker compose up -d
```

### Acceder a los servicios

- Fleet:```https://<FLEET_HOST>:1337```
- Flowise: ```http://localhost:3000```
- n8n: ```http://localhost:5678```
- Ollama: ```http://localhost:11434```
