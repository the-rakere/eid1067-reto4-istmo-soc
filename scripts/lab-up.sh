#!/usr/bin/env bash
set -euo pipefail
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ENV_FILE="$REPO_DIR/.env"
SERVICES=("wazuh" "dvwa" "waf-modsec" "suricata" "glpi" "cowrie")

if [ ! -f "$ENV_FILE" ]; then
  echo "[ERROR] Falta $ENV_FILE. Copia .env.example a .env y define tus claves."
  exit 1
fi

docker network inspect istmo_soc_net >/dev/null 2>&1 || \
  docker network create --subnet=172.25.0.0/24 istmo_soc_net

docker network inspect dmz_net >/dev/null 2>&1 || \
  docker network create --subnet=172.26.0.0/24 dmz_net

for svc in "${SERVICES[@]}"; do
  echo ">>> Levantando servicio aislado: $svc"
  docker compose --env-file "$ENV_FILE" -f "$REPO_DIR/$svc/docker-compose.yml" up -d --build
done

docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"
