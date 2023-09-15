#!/bin/bash
read -p "Enter the directory path for backup: " src
read -p "Enter the path where the backup will be stored: " dest
tar -czf "$dest/backup-$(date +'%Y%m%d').tar.gz" "$src"
echo "Backup saved in $dest."
