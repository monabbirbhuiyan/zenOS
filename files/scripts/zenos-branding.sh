#!/usr/bin/env bash
# Show "zenOS" in the boot menu, Settings > About, etc.
# ID stays "fedora" so Fedora tooling and repos keep working.
set -oue pipefail
source /usr/lib/os-release
sed -i \
  -e 's/^NAME=.*/NAME="zenOS"/' \
  -e "s/^PRETTY_NAME=.*/PRETTY_NAME=\"zenOS ${VERSION_ID} (Fedora Atomic)\"/" \
  /usr/lib/os-release
