#!/bin/bash

# Homebrew がなければインストール
if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# インストール直後は PATH 未反映のため、brew を現在のセッションに読み込む
if ! command -v brew &>/dev/null; then
    if [ -x /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -x /usr/local/bin/brew ]; then
        eval "$(/usr/local/bin/brew shellenv)"
    elif [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    else
        echo "エラー: brew が見つかりません。" >&2
        exit 1
    fi
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

## podman
brew install \
    podman
