#!/bin/sh
set -eu

echo "START: running setup..."
/scripts/setup.sh

echo "START: running packages..."
/scripts/packages.sh

echo "START: done"