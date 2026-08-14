module.exports = {
  apps: [
    {
      name: '9router',
      script: '9router',
      args: '--tray',
      interpreter: 'none',
      autorestart: true,
      env: {
        NODE_ENV: 'production',
        HOSTNAME: '0.0.0.0', // <--- Bind ke 0.0.0.0 agar bisa diakses di luar container
        PORT: 20128,
        HEADROOM_URL: 'http://localhost:8787'
      }
    },
    {
      name: 'headroom',
      script: 'headroom',
      args: 'proxy',
      interpreter: 'none',
      autorestart: true,
      env: {
        PYTHONUNBUFFERED: '1'
      }
    }
  ]
};
