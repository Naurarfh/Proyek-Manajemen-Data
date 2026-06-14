#!/bin/bash

# File daftar user
USER_FILE="daftar_user.txt"
# Password default
DEFAULT_PASS="@123"   # bagian setelah username

# Cek apakah file ada
if [ ! -f "$USER_FILE" ]; then
    echo "Error: File $USER_FILE tidak ditemukan!"
    exit 1
fi

# Baca setiap baris
while IFS= read -r username; do
    # Skip baris kosong
    if [ -z "$username" ]; then
        continue
    fi
    
    # Cek apakah user sudah ada
    if id "$username" &>/dev/null; then
        echo "User $username sudah ada, lewati."
    else
        # Buat user dengan home directory dan shell bash
        sudo useradd -m -s /bin/bash "$username"
        # Set password: namauser@123 (contoh: alice@123)
        echo "$username:${username}${DEFAULT_PASS}" | sudo chpasswd
        echo "User $username berhasil dibuat dengan password ${username}${DEFAULT_PASS}"
    fi
done < "$USER_FILE"

echo "Proses pembuatan user selesai."
