# EID1067 – Proyecto Final Reto 4: "¿Quién instaló eso?" (Instituto Universitario del Pacífico)

Infraestructura defensiva reproducida bajo la arquitectura **Homelab Istmo SOC** (UBU-SOC `10.10.10.20`, WIN-SRV22 `10.10.10.10`, FortiGate-VM `10.10.10.1`).

## Estructura del Repositorio
- `wazuh/`: Stack SIEM/XDR single-node (Manager, Indexer, Dashboard) + reglas personalizadas y listas CDB.
- `waf-modsec/`: Proxy inverso Nginx/Apache con ModSecurity + OWASP CRS delante de DVWA.
- `suricata/`: Sensor IDS en modo promiscuo (`ens33`) con firmas Emerging Threats Open y reglas locales.
- `glpi/`: Sistema de inventario y gobierno de activos (GLPI + MariaDB).
- `cowrie/`: Honeypot SSH de interacción media (legado de talleres).
- `scripts/`: Automatización de ciclo de vida (`lab-up.sh`, `lab-down.sh`, `lab-reset.sh`).
- `docs/`: Entregables documentales (E1–E9) y políticas.
- `bitacora/`: Registro semanal de decisiones, pruebas y lecciones aprendidas.
