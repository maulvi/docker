# use case punya saya

# install tailscale enable tailscale ssh
`tailscale set --ssh`
# change ssh listening to only tailscale ip
```echo "net.ipv4.ip_nonlocal_bind = 1" | sudo tee /etc/sysctl.d/99-tailscale-bind.conf

sudo sysctl -p```

`sudo systemctl edit ssh`

add this systemd lines
```
[Unit]
After=tailscaled.service
Wants=tailscaled.service
After=sys-subsystem-net-devices-tailscale0.device
Wants=sys-subsystem-net-devices-tailscale0.device
```
