# use case punya saya

# install tailscale enable tailscale ssh
`tailscale set --ssh`
# change ssh listening to only tailscale ip
`sudo systemctl edit ssh`

add this systemd lines
```
[Unit]
After=tailscaled.service
Wants=tailscaled.service
After=sys-subsystem-net-devices-tailscale0.device
Wants=sys-subsystem-net-devices-tailscale0.device

[Service]
Restart=on-failure
RestartSec=3
```
