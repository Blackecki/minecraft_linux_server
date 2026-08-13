#!/bin/bash

# Minecraft Server Backup

SERVER_DIR="/home/user/minecraft"
BACKUP_DIR="/home/user/minecraft_backup"

DATE=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/minecraft_$DATE.tar.gz"

echo "=================================="
echo " Minecraft Server Backup"
echo "=================================="
echo "Date: $DATE"
echo "Creating backup..."

mkdir -p "$BACKUP_DIR"

tar \
    --exclude="./logs" \
    --exclude="./cache" \
    --exclude="./crash-reports" \
    -czf "$BACKUP_FILE" \
    -C "$SERVER_DIR" .

if [ $? -eq 0 ]; then
    echo ""
    echo "Backup completed successfully!"
    echo "File: $BACKUP_FILE"
    echo "Size: $(du -h "$BACKUP_FILE" | cut -f1)"
else
    echo ""
    echo "ERROR: Backup failed!"
    exit 1
fi
