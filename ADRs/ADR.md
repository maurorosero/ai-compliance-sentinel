# Registro de Decisiones de Arquitectura (ADR)
## Proyecto: AI-Compliance-Sentinel

---

## ADR 001: Incorporación de Fleet DM para la Gestión de Telemetría

**Estado:** Aceptado  
**Fecha:** 2026-02-03  

### Contexto
Originalmente, el diseño del proyecto contemplaba el uso exclusivo de **Osquery** para la obtención de datos y **Ansible** para la interacción con los sistemas. Sin embargo, esta estructura puede presentar limitaciones en la escalabilidad y en la capacidad de monitorear múltiples agentes de forma centralizada y en tiempo real.

Se requiere una capa intermedia que permitiera gestionar consultas programadas y enviar alertas automáticas.

### Decisión
Añadir **Fleet DM** al stack tecnológico como el orquestador central de los agentes de Osquery.

### Justificación
- **Evolución del modelo:** Fleet permite superar el uso aislado de Osquery, facilitando la gestión de políticas globales en toda la infraestructura.
- **Puente de Integración:** Fleet actúa como el disparador (vía *Webhooks*) que comunica los hallazgos directamente a **flowise**.
- **Visibilidad:** Proporciona un inventario dinámico que **Ansible** puede utilizar como fuente de datos para documentar las recomendaciones de remediación.

### Consecuencias
Se requiere el despliegue de un contenedor para Fleet, pero se obtiene una capacidad de auditoría profesional y centralizada que el modelo anterior no permitía.

---

## ADR 002: Almacenamiento de Evidencia en MySQL 

**Estado:** Aceptado  
**Fecha:** 2026-02-03  

### Contexto
Con la adición de Fleet y la generación de alertas por IA, es crítico contar con una base de datos para persistir los logs de auditoría.

### Decisión
Utilizar **MySQL** como motor de base de datos relacional, descartando el uso de PostgreSQL.

### Justificación
- **Simplicidad de Implementación:** MySQL es altamente eficiente para el registro de logs estructurados y su configuración en contenedores es más ligera para este caso de uso.
- **Enfoque en el Problema:** Las funciones avanzadas de PostgreSQL (como tipos de datos geográficos o relacionales complejos) no son necesarias para un log de auditoría.
- **Compatibilidad de Ecosistema:** Se integra perfectamente con los nodos de base de datos de **n8n** y herramientas comunes de visualización de datos.

### Consecuencias
Se obtiene un sistema de persistencia rápido y confiable, ideal para el volumen de datos esperado en una plataforma de cumplimiento.

---

## ADR 003: Orquestación de IA y Políticas en RAG con Flowise

**Estado:** Aceptado  
**Fecha:** 2026-02-03  

### Contexto
Para que la auditoría sea realmente inteligente, el sistema debe comparar los datos de **Fleet** contra normativas de seguridad (Polices). Almacenar estas reglas en tablas SQL rígidas dificultaría su actualización y limitaría la capacidad de análisis del LLM.

### Decisión
Implementar **Flowise** para gestionar el flujo de la Inteligencia Artificial, utilizando un sistema **RAG (Retrieval-Augmented Generation)** para las políticas de cumplimiento.

### Justificación
- **Políticas en el RAG:** Las normas se cargan como documentos (PDF/MD). La IA consulta estos documentos en lugar de depender de reglas programadas fijas (*hard-coded*).
- **Análisis de Hallazgos:** Permite que modelos como **Groq** u **Ollama** generen el mensaje de alerta y la recomendación de remediación basándose en el contexto real del error detectado por Fleet.
- **Separación de Responsabilidades:** Flowise maneja la lógica cognitiva, **n8n** la orquestación de datos y **MySQL** la persistencia final.

### Consecuencias
- **Positivas:** El sistema es extremadamente flexible ante cambios en leyes o normas de seguridad.
- **Negativas:** La arquitectura se vuelve más sofisticada, requiriendo conocimiento en ingeniería de prompts y gestión de vectores.
