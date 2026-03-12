#!/bin/bash

# RDP + XFCE4 デスクトップセットアップスクリプト (WSL2用)
#
# 接続方法:
#   1. WSL2のIPを確認: hostname -I
#   2. Windowsで mstsc.exe を開き <WSL2のIP>:3389 に接続
#   3. Ubuntuのユーザー名・パスワードでログイン
#
# ワンライナー接続 (PowerShellで実行):
#   mstsc /v:"$(wsl hostname -I):3389"

set -e

if ! sudo -v 2>/dev/null; then
    echo "エラー: sudo権限が必要です。" >&2
    exit 1
fi

echo "=== RDP + XFCE4 デスクトップセットアップ ==="

sudo apt update

# XFCE4 デスクトップ環境
sudo apt install -y \
    xfce4 \
    xfce4-goodies \
    xfce4-terminal

# xrdp
sudo apt install -y xrdp

# 日本語フォント・インプットメソッド
sudo apt install -y \
    fonts-noto-cjk \
    fonts-noto-color-emoji \
    fcitx5 \
    fcitx5-mozc \
    fcitx5-config-qt

# ブラウザ: Firefox (apt版)
# Ubuntu 22.04はchromium/firefoxがsnap専用のため、Mozilla公式PPAから取得
sudo add-apt-repository -y ppa:mozillateam/ppa
# snapより優先度を上げる
sudo tee /etc/apt/preferences.d/mozilla-firefox > /dev/null << 'EOF'
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
EOF
sudo apt update
sudo apt install -y firefox

# xrdpをssl-certグループに追加 (証明書エラー防止)
sudo adduser xrdp ssl-cert 2>/dev/null || true

# xrdpセッションでXFCE4を使う設定
cat > "$HOME/.xsession" << 'EOF'
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
fcitx5 -d &
exec startxfce4
EOF
chmod +x "$HOME/.xsession"

# xrdp起動
sudo service xrdp start

# WSL起動時にxrdpを自動起動 (wsl.confに追記)
WSL_CONF=/etc/wsl.conf
if grep -q "^\[boot\]" "$WSL_CONF" 2>/dev/null; then
    # [boot]セクションが既存 → commandを更新
    sudo sed -i '/^\[boot\]/,/^\[/ s|^command=.*|command="service xrdp start"|' "$WSL_CONF"
else
    echo -e '\n[boot]\ncommand="service xrdp start"' | sudo tee -a "$WSL_CONF" > /dev/null
fi

WSL_IP=$(hostname -I | awk '{print $1}')
echo ""
echo "=== セットアップ完了 ==="
echo ""
echo "接続方法:"
echo "  1. WSL2のIP確認: hostname -I  (現在: ${WSL_IP})"
echo "  2. Windowsで mstsc.exe を開き ${WSL_IP}:3389 に接続"
echo "  3. Ubuntuのユーザー名・パスワードでログイン"
echo ""
echo "PowerShellワンライナー:"
echo '  mstsc /v:"$(wsl hostname -I):3389"'
echo ""
echo "xrdpを手動で起動するには:"
echo "  sudo service xrdp start"
echo ""
echo "注意: WSL再起動後は自動でxrdpが起動します。IPは起動のたびに変わります。"
