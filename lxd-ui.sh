#!/usr/bin/env bash
set -e

[[ $EUID -eq 0 ]] || {
  echo "Jalankan: sudo $0"
  exit 1
}

# Deteksi user yang menjalankan sudo
if [[ -n "${SUDO_USER:-}" ]]; then
  ADMIN_USER="$SUDO_USER"
else
  read -rp "Username admin LXD: " ADMIN_USER
fi

[[ -n "$ADMIN_USER" ]] || {
  echo "Username tidak boleh kosong."
  exit 1
}

id "$ADMIN_USER" >/dev/null 2>&1 || {
  echo "User '$ADMIN_USER' tidak ditemukan."
  exit 1
}

echo "== Install snapd =="
apt update
apt install -y snapd
systemctl enable --now snapd.socket

echo "== Install LXD =="
snap list lxd >/dev/null 2>&1 || snap install lxd

export PATH="$PATH:/snap/bin"
hash -r

command -v lxd >/dev/null 2>&1 || {
  echo "LXD tidak ditemukan. Cek: /snap/bin/lxd version"
  exit 1
}

echo "== Tambah $ADMIN_USER ke grup lxd =="
usermod -aG lxd "$ADMIN_USER"

# Aktifkan grup lxd untuk user ini sekarang (tanpa logout/login)
sg lxd -c "echo 'Grup lxd aktif untuk sesi ini.'"

echo "== Setup LXD =="
lxd init

echo "== Enable LXD UI =="

read -rp "Bind address [127.0.0.1]: " LXD_BIND
LXD_BIND="${LXD_BIND:-127.0.0.1}"

read -rp "Port LXD UI [8443]: " LXD_PORT
LXD_PORT="${LXD_PORT:-8443}"

[[ "$LXD_PORT" =~ ^[0-9]+$ ]] && (( LXD_PORT >= 1 && LXD_PORT <= 65535 )) || {
  echo "Port tidak valid: $LXD_PORT"
  exit 1
}

lxc config set core.https_address "${LXD_BIND}:${LXD_PORT}"

echo
echo "Selesai."
echo "User '$ADMIN_USER' sudah ditambahkan ke grup lxd."
echo "Untuk sesi shell saat ini, grup lxd sudah aktif."
echo "LXD UI: https://${LXD_BIND}:${LXD_PORT}"
