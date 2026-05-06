#!/bin/bash

# Homebrew がなければインストール
if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

## ユーティリティ
brew install \
    curl \
    wget \
    jq \
    zip \
    unzip \
    direnv

## ネットワーク
brew install \
    nmap

## 検索
brew install \
    fzf \
    ripgrep

## 管理
brew install \
    tree \
    tmux

## 開発ツール
brew install \
    shellcheck \
    shfmt
