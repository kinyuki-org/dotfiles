#!/bin/bash

if ! sudo -v 2>/dev/null; then
    echo "エラー: sudo権限が必要です。" >&2
    exit 1
fi

# gh CLI インストール
GH_VERSION=$(curl -s https://api.github.com/repos/cli/cli/releases/latest | jq -r '.tag_name | ltrimstr("v")')
curl -sL "https://github.com/cli/cli/releases/latest/download/gh_${GH_VERSION}_linux_amd64.tar.gz" \
    | tar -xz -C /tmp
sudo install /tmp/gh_${GH_VERSION}_linux_amd64/bin/gh /usr/local/bin/gh
rm -rf /tmp/gh_${GH_VERSION}_linux_amd64

# --- SSH Agent 自動起動を .bashrc に追記 ---
if ! grep -q "SSH Agent 自動起動" ~/.bashrc; then
    cat >> ~/.bashrc << 'EOF'

# --- SSH Agent 自動起動 ---
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval $(ssh-agent -s) > /dev/null
    ssh-add ~/.ssh/id_ed25519 2>/dev/null
fi
EOF
    echo "SSH Agent 自動起動を .bashrc に追記しました。"
fi

# ============================================================
# SSH鍵セットアップ（手動手順）
# ============================================================
# 以下は自動化が難しいため手動で実施する
#
# 1. SSH鍵生成
#    ssh-keygen -t ed25519 -C "74060654+kinyuki0510@users.noreply.github.com"
#
# 2. GitHubに公開鍵を登録（認証用・署名用の2つ）
#    gh ssh-key add ~/.ssh/id_ed25519.pub --title "マシン名" --type authentication
#    gh ssh-key add ~/.ssh/id_ed25519.pub --title "マシン名" --type signing
#
# 3. gitの署名設定
#    git config --global gpg.format ssh
#    git config --global user.signingkey ~/.ssh/id_ed25519.pub
#    git config --global commit.gpgsign true
#
# 4. SSH接続確認
#    ssh -T git@github.com
