# InfraMonitor Lite – VirtualBox Monitoring Stack

This project sets up a lightweight monitoring and alerting system using **Uptime Kuma** inside a VirtualBox-hosted Ubuntu Server VM. It runs 24/7, sends alerts via Discord, and can be configured to auto-start on boot.

## Features

- Self-hosted Uptime Kuma with Docker
- Monitors websites, IP addresses, or services
- Sends Discord alerts on failure
- Automatically runs on system startup via systemd
- Designed for "set-and-forget" use in a VirtualBox VM

## Requirements

- VirtualBox
- Ubuntu Server (20.04 or 22.04 recommended)
- Docker and Docker Compose installed on guest

## Setup

### 1. Install Docker and Docker Compose

```bash
sudo apt update
sudo apt install -y docker.io docker-compose
sudo systemctl enable docker
```

### 2. Clone and Start Kuma

```bash
git clone https://github.com/Jeandu23/infra-monitor-lite.git
cd infra-monitor-lite
docker-compose up -d
```

Uptime Kuma will be available at `http://<your-vm-ip>:3001`

### 3. Set Kuma to Run on Boot

Create a `kuma.service` file in `/etc/systemd/system/`:

```ini
[Unit]
Description=Uptime Kuma Docker Compose
Requires=docker.service
After=docker.service

[Service]
WorkingDirectory=/home/youruser/infra-monitor-lite
ExecStart=/usr/bin/docker-compose up -d
ExecStop=/usr/bin/docker-compose down
Restart=always
User=youruser

[Install]
WantedBy=multi-user.target
```

Then run:
```bash
sudo systemctl enable kuma.service
sudo systemctl start kuma.service
```

### 4. Set Up a Monitor and Discord Alert

- Add a new monitor for `8.8.8.8` (Google DNS) or a site like `https://example.com`
- Add a Discord webhook under **Notification**

---

## License

MIT
