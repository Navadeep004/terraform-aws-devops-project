#!/bin/bash

set -e

mkdir -p /opt/devops-app

cat <<'EOF' > /opt/devops-app/index.html
<!DOCTYPE html>
<html>
<head>
    <title>Terraform AWS DevOps Project</title>
</head>
<body>
    <h1>Terraform AWS DevOps Project</h1>
    <p>Application is running successfully.</p>
    <p>Infrastructure: AWS + Terraform + Jenkins</p>
</body>
</html>
EOF

cat <<'EOF' > /etc/systemd/system/devops-app.service
[Unit]
Description=DevOps Demo Application
After=network.target

[Service]
Type=simple
WorkingDirectory=/opt/devops-app
ExecStart=/usr/bin/python3 -m http.server 8080 --bind 0.0.0.0
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable devops-app
systemctl start devops-app