#!/bin/bash

# Kiem tra tham so
if [ "$#" -ne 1 ] || [ ! -d "$1" ]; then
    echo "Loi: Can nhap mot thu muc hop le!"
    echo "Cach dung: $0 <thu_muc>"
    exit 1
fi

# Xac dinh thu muc can sao luu
SOURCE=$(realpath "$1")
NAME=$(basename "$SOURCE")
TIME=$(date +%Y%m%d_%H%M%S)

# Tao thu muc backup
mkdir -p "$HOME/backup"

# Ten file backup
DEST="$HOME/backup/${NAME}_${TIME}.tar.gz"

# Nen thu muc
if ! tar -czf "$DEST" -C "$(dirname "$SOURCE")" "$NAME"; then
    echo "Loi: Sao luu that bai!"
    exit 1
fi

# Ghi nhat ky
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
PROJECT_DIR=$(dirname "$SCRIPT_DIR")

echo "$(date '+%Y-%m-%d %H:%M:%S') | $DEST" >> "$PROJECT_DIR/logs/backup.log"

echo "Sao luu thanh cong!"
echo "File: $DEST"
