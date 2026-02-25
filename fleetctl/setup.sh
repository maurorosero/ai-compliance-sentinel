#!/bin/sh
set -eu

fleetctl config set --address "$FLEET_ADDRESS" --tls-skip-verify

echo "Running Fleet setup (if needed)..."
fleetctl setup \
  --org-name "$FLEET_ORG_NAME" \
  --name "$FLEET_ADMIN_NAME" \
  --email "$FLEET_ADMIN_EMAIL" \
  --password "$FLEET_ADMIN_PASSWORD" \
  >/dev/null 2>&1 || true

# Login
if ! fleetctl login --email "$FLEET_ADMIN_EMAIL" --password "$FLEET_ADMIN_PASSWORD"; then
  echo "ERROR: fleetctl login failed (401). Fleet is likely already setup with different admin credentials." >&2
  exit 1
fi

cat >/tmp/enroll.yml <<YAML
apiVersion: v1
kind: enroll_secret
spec:
  secrets:
    - secret: "${FLEET_ENROLL_SECRET}"
YAML

fleetctl apply -f /tmp/enroll.yml
echo "Setup OK."