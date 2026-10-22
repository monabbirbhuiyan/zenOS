#!/usr/bin/env bash
# Boot straight into the graphical login screen (base-main ships without a desktop).
set -oue pipefail
systemctl set-default graphical.target
