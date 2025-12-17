#!/bin/bash

set -ouex pipefail

cat << 'EOF' > /etc/systemd/system/install-zena.service
[Unit]
Description=BootC switch installer
Before=getty@tty1.service

[Service]
Type=oneshot
ExecStart=/usr/bin/bootc switch --apply ghcr.io/jianzcar/zena:stable

StandardOutput=tty
StandardError=tty
TTYPath=/dev/tty1
TTYReset=yes
TTYVHangup=yes

RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF

systemctl enable podman.socket install-zena.service
