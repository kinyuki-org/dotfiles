#!/bin/bash

# WSL側VSCode拡張機能インストールスクリプト
# Remote-WSL接続時に動作する言語・開発ツール系の拡張機能
#
# Windows側の拡張機能は windows/vscode-extensions.ps1 を参照

## エディタ補助
code --install-extension hediet.vscode-drawio
code --install-extension patbenatar.advanced-new-file
code --install-extension alefragnani.project-manager
code --install-extension codezombiech.gitignore
code --install-extention mads-hartmann.bash-ide-vscode

## AI
code --install-extension github.copilot
code --install-extension github.copilot-chat
code --install-extension anthropic.claude-code

## Python
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension ms-python.debugpy
code --install-extension ms-python.vscode-python-envs
code --install-extension charliermarsh.ruff

## ドキュメント (WIN/WSL両側にインストール)
code --install-extension yzhang.markdown-all-in-one
code --install-extension bierner.markdown-mermaid

## GitHub
code --install-extension github.vscode-pull-request-github
