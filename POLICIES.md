# POLICIES.md — Contrato Maestro de Cumplimiento

El archivo POLICIES.md no será utilizado directamente dentro del flujo de razonamiento del **AI-Compliance Real-Time Sentinel** . Estas políticas constituyen un marco base de cumplimiento y serán implementadas como policies dentro de Fleet para su aplicación y monitoreo en la flota. La IA operará sobre la telemetría generada por dichas policies, no sobre este documento como fuente directa de decisión.

Alcance: políticas aplicables y auditables con osquery en Windows.

---

## POL-001. Acceso y Autenticación

* **1.1:** No deben existir usuarios con contraseñas vacías en ninguna base de datos local del sistema.
* **1.2:** La política local de seguridad debe estar configurada para bloquear la cuenta tras 5 intentos fallidos de inicio de sesión en un período máximo de 10 minutos.
* **1.3:** Prohibición de cuentas de "Invitado" (Guest) activas en el sistema operativo.
* **1.4:** La política local debe establecer una expiración máxima de contraseña no mayor a 90 días.

---

## POL-002. Red y Conectividad

* **2.1:** Denegación por defecto: solo puertos autorizados (80, 443, 22) pueden estar en estado `LISTEN`.
* **2.2:** Firewall (ufw, iptables, Windows Firewall) activo con reglas de salida restrictivas.
* **2.3:** Prohibido el uso de herramientas de interceptación de tráfico (Nmap, Wireshark, Tcpdump) sin ticket de soporte activo.
* **2.4:** Prohibida la instalación de software de control remoto no corporativo (ej. AnyDesk, TeamViewer personal).
* **2.5:** Las características o servicios de Telnet y FTP no deben estar instalados ni habilitados en el sistema.

---

## POL-003. Integridad de Software y Procesos

* **3.1:** Prohibición absoluta de clientes P2P o Torrent.
* **3.2:** El sistema no debe tener actualizaciones críticas pendientes de instalación.
* **3.3:** Agente de protección (Antivirus/EDR) siempre en ejecución y con la base de firmas actualizada al día.
* **3.4:** Bloqueo de ejecución de scripts no firmados en intérpretes como PowerShell o Python.
* **3.5:** Deshabilitar la ejecución automática (AutoRun/AutoPlay) para todos los medios y unidades.

---

## POL-004. Gestión de Logs y Auditoría

* **4.1:** El subsistema de auditoría (auditd/EventLog) debe tener integridad de escritura y no puede ser detenido.
* **4.2:** El servicio de registro de eventos de Windows debe estar configurado en inicio automático y en estado "running".

---

## POL-005. Cifrado y Almacenamiento

* **5.1:** Cifrado de disco completo (FDE) obligatorio para todos los dispositivos portátiles.
* **5.2:** La política del sistema debe tener configurado el bloqueo de escritura en dispositivos de almacenamiento extraíble mediante claves de registro activas.
* **5.3:** Prohibición de montar unidades de red compartidas mediante protocolos obsoletos (SMBv1).

---

## POL-006. Configuración y Hardening (Reforzamiento)

* **6.1:** Deshabilitar servicios innecesarios (ej. Bluetooth en servidores, servicios de impresión si no se usan).
* **6.2:** La BIOS/UEFI debe estar protegida por contraseña y tener el **Secure Boot** activado.

---

## POL-007. Uso de Recursos y Comportamiento

* **7.1:** Alerta ante picos de uso de CPU (>90%) sostenidos por más de 5 minutos en procesos no identificados (Detección de Cryptomining).
* **7.2:** Debe estar habilitado el monitoreo de eventos de archivos (File Integrity Monitoring) en directorios críticos del sistema mediante osquery.

---



