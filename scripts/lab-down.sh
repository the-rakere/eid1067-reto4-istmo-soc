#!/usr/bin/env bash
set -euo pipefail
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ENV_FILE="$REPO_DIR/.env"
SERVICES=("cowrie" "glpi" "suricata" "waf-modsec" "dvwa" "wazuh")
REMOVE_VOLUMES="${1:-}"

if [ -f "$ENV_FILE" ]; then
  set -a
  # shellcheck disable=SC1090
  source "$ENV_FILE"
  set +a
fi

if docker compose version >/dev/null 2>&1; then
  COMPOSE_CMD=(docker compose)
elif command -v docker-compose >/dev/null 2>&1; then
  COMPOSE_CMD=(docker-compose)
else
  echo "[ERROR] Ni 'docker compose' ni 'docker-compose' están disponibles."
  exit 1
fi

for svc in "${SERVICES[@]}"; do
  echo ">>> Deteniendo servicio aislado: $svc"
  if [ "$REMOVE_VOLUMES" == "--volumes" ]; then
    "${COMPOSE_CMD[@]}" -f "$REPO_DIR/$svc/docker-compose.yml" down -v --remove-orphans
  else
    "${COMPOSE_CMD[@]}" -f "$REPO_DIR/$svc/docker-compose.yml" down --remove-orphans
  fi
done
