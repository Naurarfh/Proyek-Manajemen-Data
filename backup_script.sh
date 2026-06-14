#!/bin/bash

# Konfigurasi
BACKUP_DIR="/backup"
# Ganti dengan direktori kecil. Contoh: backup folder konfigurasi sistem
SOURCE_DIR="/etc"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/backup_$DATE.tar.gz"
LOG_FILE="/var/log/backup.log"

# Buat direktori backup jika belum ada
sudo mkdir -p "$BACKUP_DIR"

echo "Memulai backup dari $SOURCE_DIR ke $BACKUP_FILE ..."

# Lakukan backup dengan sudo dan tampilkan progress
sudo tar -czf "$BACKUP_FILE" "$SOURCE_DIR"

# Cek hasil
if [ $? -eq 0 ]; then
    SIZE=$(du -h "$BACKUP_FILE" | cut -f1)
    echo "$(date) - Backup sukses: $BACKUP_FILE (ukuran: $SIZE)" | sudo tee -a "$LOG_FILE"
    echo "Backup berhasil! File: $BACKUP_FILE (ukuran: $SIZE)"
else
    echo "$(date) - Backup GAGAL" | sudo tee -a "$LOG_FILE"
    echo "Backup GAGAL. Periksa error di atas."
fi

# Hapus backup lama lebih dari 7 hari (agar tidak penuh)
sudo find "$BACKUP_DIR" -name "*.tar.gz" -mtime +7 -delete



