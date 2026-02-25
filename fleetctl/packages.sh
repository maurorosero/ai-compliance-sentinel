#!/bin/sh
set -eu

# En tu imagen el artefacto se genera directamente aquí:
BUILD_OUT="/scripts/build"

retry() {
  tries="${1:-5}"
  delay="${2:-5}"
  shift 2

  i=1
  while :; do
    if "$@"; then
      return 0
    fi

    if [ "$i" -ge "$tries" ]; then
      echo "ERROR: command failed after ${tries} attempts: $*" >&2
      return 1
    fi

    echo "WARN: command failed (attempt $i/$tries). Retrying in ${delay}s..." >&2
    i=$((i+1))
    sleep "$delay"
  done
}

generate() {
  type="$1"
  filename="${INSTALLER_NAME}.${type}"
  outfile="/out/${filename}"

  echo "Generating ${type} -> ${outfile}"

  retry 5 5 fleetctl package \
    --type="$type" \
    --fleet-url="$FLEET_ENROLL_URL" \
    --enroll-secret="$FLEET_ENROLL_SECRET" \
    --insecure \
    --outfile="$filename"

  # Copia el artefacto generado al bind mount (/out)
  if [ -f "${BUILD_OUT}/${filename}" ]; then
    cp -f "${BUILD_OUT}/${filename}" "$outfile"
  else
    echo "ERROR: Expected artifact not found: ${BUILD_OUT}/${filename}" >&2
    echo "Contents of ${BUILD_OUT}:" >&2
    ls -lah "${BUILD_OUT}" >&2 || true
    exit 1
  fi
}

: "${INSTALLER_NAME:?Missing INSTALLER_NAME}"
: "${FLEET_ENROLL_URL:?Missing FLEET_ENROLL_URL}"
: "${FLEET_ENROLL_SECRET:?Missing FLEET_ENROLL_SECRET}"

[ "${GENERATE_MSI:-false}" = "true" ] && generate "msi"
[ "${GENERATE_DEB:-false}" = "true" ] && generate "deb"
[ "${GENERATE_RPM:-false}" = "true" ] && generate "rpm"
[ "${GENERATE_PKG:-false}" = "true" ] && generate "pkg"

echo "Packages ready in /out:"
ls -lah /out || true