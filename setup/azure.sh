#!/bin/bash

if ! sudo -v 2>/dev/null; then
    echo "エラー: sudo権限が必要です。" >&2
    exit 1
fi

# Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

az --version
