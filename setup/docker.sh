#!/bin/bash

if ! sudo -v 2>/dev/null; then
    echo "エラー: sudo権限が必要です。" >&2
    exit 1
fi

# Dockerインストール
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker $USER

# WSL2自動起動設定
if grep -q "microsoft" /proc/version 2>/dev/null; then
    echo '[boot]command="service docker start"' | sudo tee /etc/wsl.conf
fi