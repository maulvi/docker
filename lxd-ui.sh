#!/usr/bin/env bash
set -e

[[ $EUID -eq 0 ]] || {
  echo "Jalankan pakai sudo."
  exit 1
}

read -rp "Username admin LXD [${SUDO_USER:-$USER}]: " ADMIN_USER
ADMIN_USER="${ADMIN_USER:-${SUDO_USER:-$USER}}"

id "$ADMIN_USER" &>/dev/null || {
  echo "User '$ADMIN_USER' tidak ditemukan."
  exit 1
}

echo
echo "== Install dependency =="
apt update
apt install -y snapd

echo
echo "== Install LXD =="
if ! snap list lxd >/dev/null 2>&1; then
  snap install lxd
else
  echo "LXD sudah terinstall."
fi

echo
echo "== Tambah user ke grup lxd =="
usermod -aG lxd "$ADMIN_USER"

echo
echo "== Setup LXD =="
echo "Pilih konfigurasi sendiri. Jangan asal pilih disk/network."
lxd init

echo
echo "== Enable LXD UI local-only =="
lxc config set core.https_address 127.0.0.1:8443

echo
echo "Selesai."
echo "Logout/login dulu agar group lxd aktif."
echo
echo "Akses UI dari host:"
echo "  https://127.0.0.1:8443"
echo
echo "Akses dari PC lain via SSH tunnel:"
echo "  ssh -L 8443:127.0.0.1:8443 $ADMIN_USER@IP_SERVER"
echo "Lalu buka: https://127.0.0.1:8443"
