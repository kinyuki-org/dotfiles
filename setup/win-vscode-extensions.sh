#!/bin/bash

# Windows側VSCode拡張機能インストールスクリプト
# WSLから実行: bash windows/vscode-extensions.sh
#
# Windows側に入れる理由:
#   - Remote系: WSL/SSH/DevContainerへの接続はWindows(ホスト)側で動く
#   - UI系(Vim等): キー入力処理はホスト側で行われる
#   - Docker: DevContainer起動にはホスト側のDocker接続が必要

code() { powershell.exe -Command "code --install-extension $1"; }

## Remote接続 (WSL / SSH / DevContainer / RemoteExplorerを含むパック)
code ms-vscode-remote.vscode-remote-extensionpack

## Docker / DevContainer
code ms-azuretools.vscode-docker
code ms-azuretools.vscode-containers

## UI系 (ホスト側で動作するため)
code vscodevim.vim
code voidei.vscode-vimrc

## ドキュメント (WIN/WSL両側にインストール)
code hediet.vscode-drawio
code bierner.markdown-mermaid
code yzhang.markdown-all-in-one
