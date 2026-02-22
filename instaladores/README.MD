# Carpeta instaladores/

La carpeta instaladores/ funciona como directorio de destino para los instaladores generados automáticamente por el contenedor fleetctl.

Su propósito es:

- [ ] Almacenar los binarios/paquetes generados por fleetctl.
- [ ] Servir como punto central de distribución de los instaladores.
- [ ] Permitir su posterior despliegue automatizado mediante Ansible.

Esta carpeta no contiene instaladores creados manualmente.
Su contenido es generado como parte del flujo de construcción del entorno y luego utilizado en procesos de automatización para distribuir los agentes o componentes necesarios en los sistemas destino.

En resumen, actúa como artefact repository local dentro del proyecto, facilitando la integración entre la generación de instaladores y su despliegue automatizado.
