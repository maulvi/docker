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
```

2.Tambahkan konfigurasi dependency:Pada teks editor yang terbuka, ketikkan baris berikut di bagian paling atas (pastikan tidak berada di dalam baris komentar yang diawali dengan #):Ini, TOML[Unit]
After=tailscaled.service
Wants=tailscaled.service
