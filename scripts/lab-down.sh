#!/usr/bin/env bash
set -euo pipefail
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ENV_FILE="$REPO_DIR/.env"
SERVICES=("cowrie" "glpi" "suricata" "waf-modsec" "dvwa" "wazuh")
REMOVE_VOLUMES="${1:-}"

for svc in "${SERVICES[@]}"; do
  echo ">>> Deteniendo servicio aislado: $svc"
  if [ "$REMOVE_VOLUMES" == "--volumes" ]; then
    docker compose --env-file "$ENV_FILE" -f "$REPO_DIR/$svc/docker-compose.yml" down -v --remove-orphans
  else
    docker compose --env-file "$ENV_FILE" -f "$REPO_DIR/$svc/docker-compose.yml" down --remove-orphans
  fi
done
