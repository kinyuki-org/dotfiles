#!/bin/bash

if ! sudo -v 2>/dev/null; then
    echo "エラー: sudo権限が必要です。" >&2
    exit 1
fi

sudo apt update

## ユーティリティ
sudo apt install -y \
    wslu \
    curl \
    wget \
    jq \
    zip \
    unzip \
    direnv

## ネットワーク
sudo apt install -y \
    iputils-ping \
    net-tools \
    iproute2 \
    dnsutils \
    nmap

## 検索
sudo apt install -y \
    fzf \
    ripgrep

## 管理
sudo apt install -y \
    tree \
    tmux

## 開発ツール
sudo apt install -y \
    shellcheck \
    shfmt
