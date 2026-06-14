#!/bin/bash
# Menampilkan persentase sisa space pada partisi root (/)
FREE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
echo "Notifikasi: space HDD anda tinggal $((100 - FREE))%"
