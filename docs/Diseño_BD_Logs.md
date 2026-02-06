# Diseño de la Base de Datos: Sistema de Auditoría AI-Compliance-Sentinel

## 1. Introducción

Este documento detalla el diseño de la base de datos para el proyecto de pasantía **AI-Compliance-Sentinel**.  
La base de datos tiene como objetivo principal servir como un **almacén de evidencia de auditoría inmutable**.

A diferencia de los sistemas tradicionales, este diseño sigue un enfoque de **IA-Primero**, donde las políticas de cumplimiento residen en un sistema **RAG (Retrieval-Augmented Generation)** dentro de **Flowise**, y la base de datos solo persiste los hallazgos que la inteligencia artificial determina como infracciones.

---

## 2. Contexto de Arquitectura

- **Fuente de Datos:** Fleet DM (Osquery)  
- **Capa de Decisión:** n8n y Flowise (LLM)  
- **Motor de Base de Datos:** MySQL  
- **Lógica de Guardado:**  
  La IA analiza la telemetría y, solo si detecta una anomalía o incumplimiento según el RAG, ordena la inserción del registro en MySQL.

---

## 3. Diagrama de Entidad-Relación (ERD)

A continuación se representa la estructura de la tabla principal de hallazgos utilizando sintaxis **Mermaid**:

```mermaid
erDiagram
    AUDIT_LOGS {
        int id_log PK "Autoincremental"
        varchar log_identifier "Código único del evento"
        varchar machine_id "Identificador del equipo (Fleet)"
        datetime timestamp "Fecha y hora exacta del hallazgo"
        text alert_message "Cuerpo de la alerta y recomendación"
    }


## 4. Diccionario de Datos

### Tabla: `audit_logs`

Esta tabla almacena cada incidencia de cumplimiento detectada y validada por la capa de inteligencia artificial.

| Campo            | Tipo          | Nulidad   | Descripción |
|------------------|---------------|-----------|-------------|
| `id_log`         | INT           | NOT NULL  | Clave primaria autoincremental para control interno. |
| `log_identifier` | VARCHAR(100)  | NOT NULL  | Etiqueta técnica que identifica el log. |
| `machine_id`     | VARCHAR(50)   | NOT NULL  | Identificador único del agente/máquina proporcionado por Fleet. |
| `timestamp`      | DATETIME      | NOT NULL  | Registra el momento exacto (año, mes, día, hora, minuto) del hallazgo. |
| `alert_message`  | TEXT          | NOT NULL  | Mensaje detallado generado por la IA con la explicación del hallazgo. |



## 5. Implementación SQL (DDL)
-- Creación de la base de datos para el proyecto
CREATE DATABASE IF NOT EXISTS ai_compliance_db;
USE ai_compliance_db;

-- Creación de la tabla de logs de auditoría
CREATE TABLE audit_logs (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    log_identifier VARCHAR(100) NOT NULL,
    machine_id VARCHAR(50) NOT NULL,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    alert_message TEXT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
