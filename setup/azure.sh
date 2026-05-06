#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS: Homebrew でインストール
    brew install azure-cli
else
    # Linux/WSL
    if ! sudo -v 2>/dev/null; then
        echo "エラー: sudo権限が必要です。" >&2
        exit 1
    fi

    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
fi

az --version
