#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "=== DESTRUYENDO LABORATORIO COMPLETO (CONTENEDORES + VOLÚMENES) ==="
"$SCRIPT_DIR/lab-down.sh" --volumes
echo "=== RECONSTRUYENDO LABORATORIO DESDE CERO ==="
"$SCRIPT_DIR/lab-up.sh"
