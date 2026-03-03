#!/bin/bash

if ! sudo -v 2>/dev/null; then
    echo "エラー: sudo権限が必要です。" >&2
    exit 1
fi

# Google Cloud CLI
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" \
    | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list

sudo apt update
sudo apt install -y google-cloud-cli

gcloud --version
