

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
echo "Logout/login sebagai $ADMIN_USER agar grup lxd aktif."
echo "LXD UI: https://${LXD_BIND}:${LXD_PORT}"
