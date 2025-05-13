#!/bin/bash
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
BACKUP_DIR=~/kuma_backups
mkdir -p "$BACKUP_DIR"
docker run --rm -v uptime-kuma:/data -v "$BACKUP_DIR":/backup alpine tar czf "/backup/kuma-backup-$TIMESTAMP.tar.gz" -C /data .
echo "Backup saved to $BACKUP_DIR/kuma-backup-$TIMESTAMP.tar.gz"
