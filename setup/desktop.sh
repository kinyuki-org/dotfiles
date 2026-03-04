#!/bin/bash

# WSLg + XFCE4 デスクトップセットアップスクリプト
# 前提: Windows 11 または Windows 10 21H2以降 + WSL2

set -e

if ! sudo -v 2>/dev/null; then
    echo "エラー: sudo権限が必要です。" >&2
    exit 1
fi

# WSLg確認
if [ ! -d /mnt/wslg ]; then
    echo "エラー: WSLgが利用できません。" >&2
    echo "Windows 11 または Windows 10 21H2以降 + WSL2が必要です。" >&2
    echo "WSLを最新版に更新してください: wsl --update (PowerShellで実行)" >&2
    exit 1
fi

echo "=== WSLg + XFCE4 デスクトップセットアップ ==="

sudo apt update

# XFCE4 デスクトップ環境
sudo apt install -y \
    xfce4 \
    xfce4-goodies \
    xfce4-terminal

# 日本語フォント・インプットメソッド
sudo apt install -y \
    fonts-noto-cjk \
    fonts-noto-color-emoji \
    fcitx5 \
    fcitx5-mozc \
    fcitx5-config-qt

# ブラウザ (Chromium)
sudo apt install -y chromium-browser || sudo apt install -y chromium

# ファイルマネージャー等 (xfce4-goodiesに含まれるが念のため)
sudo apt install -y \
    thunar \
    mousepad

# D-Bus (GUIアプリに必要)
sudo apt install -y dbus-x11

# 起動スクリプト作成
LAUNCHER="$HOME/.local/bin/start-desktop"
mkdir -p "$HOME/.local/bin"
cat > "$LAUNCHER" << 'EOF'
#!/bin/bash
# XFCE4セッション起動 (WSLg用)

# X11強制 (Waylandは使わない)
export DISPLAY=:0
unset WAYLAND_DISPLAY
export GDK_BACKEND=x11
export QT_QPA_PLATFORM=xcb

# XDG_RUNTIME_DIR - WSLgのデフォルト(/mnt/wslg/runtime-dir)はパーミッション問題あり
XDG_RUN="/run/user/$(id -u)"
if [ ! -d "$XDG_RUN" ]; then
    sudo mkdir -p "$XDG_RUN"
    sudo chown "$(whoami):$(whoami)" "$XDG_RUN"
    sudo chmod 700 "$XDG_RUN"
fi
export XDG_RUNTIME_DIR="$XDG_RUN"

# fcitx5 (日本語入力)
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

# D-Bus
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    eval "$(dbus-launch --sh-syntax)"
fi

fcitx5 -d 2>/dev/null &
exec xfce4-session
EOF
chmod +x "$LAUNCHER"

# PATH追加 (.bashrcに未追加の場合のみ)
if ! grep -q '\.local/bin' "$HOME/.bashrc"; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
fi

echo ""
echo "=== セットアップ完了 ==="
echo ""
echo "デスクトップを起動するには:"
echo "  start-desktop"
echo ""
echo "または直接:"
echo "  startxfce4"
echo ""
echo "注意: 初回起動時はXFCEの設定ウィザードが表示されます。"
echo "      WSLを再起動するか、新しいターミナルを開いてから実行してください。"
