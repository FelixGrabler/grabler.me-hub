#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WORKSPACE_DIR="$(cd "${ROOT_DIR}/.." && pwd)"
LINKSHORTENER_DIR="${WORKSPACE_DIR}/linkshortener"
NAMO_DIR="${WORKSPACE_DIR}/Namo"

FORCE="${1:-}"

random_value() {
  python3 - <<'PY'
import secrets
print(secrets.token_urlsafe(48))
PY
}

write_secret() {
  local path="$1"
  local value="$2"

  mkdir -p "$(dirname "$path")"

  if [[ -f "$path" && "$FORCE" != "--force" ]]; then
    echo "Skipping existing $path"
    return
  fi

  printf '%s\n' "$value" > "$path"
  chmod 600 "$path"
  echo "Wrote $path"
}

SHARED_JWT_SECRET="$(random_value)"
AUTH_DB_PASSWORD="$(random_value)"
LINK_DB_PASSWORD="$(random_value)"
NAMO_DB_PASSWORD="$(random_value)"

write_secret "${ROOT_DIR}/secrets/auth_jwt_secret.txt" "${SHARED_JWT_SECRET}"
write_secret "${ROOT_DIR}/secrets/auth_postgres_password.txt" "${AUTH_DB_PASSWORD}"

if [[ -d "${LINKSHORTENER_DIR}" ]]; then
  write_secret "${LINKSHORTENER_DIR}/secrets/auth_jwt_secret.txt" "${SHARED_JWT_SECRET}"
  write_secret "${LINKSHORTENER_DIR}/secrets/postgres_password.txt" "${LINK_DB_PASSWORD}"
fi

if [[ -d "${NAMO_DIR}" ]]; then
  write_secret "${NAMO_DIR}/secrets/prod_secret_key.txt" "${SHARED_JWT_SECRET}"
  write_secret "${NAMO_DIR}/secrets/prod_postgres_password.txt" "${NAMO_DB_PASSWORD}"
fi

echo
echo "Shared auth secret files are ready."
echo "Use --force to overwrite existing files."
