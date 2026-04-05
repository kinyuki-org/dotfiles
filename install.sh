#!/usr/bin/env bash
# ============================================================
# install.sh
# dotfiles をホームディレクトリにシンボリックリンクで展開する
#
# 使い方:
#   bash ~/work/dotfiles/install.sh
#
# 既存ファイルは .bak を付けてバックアップしてからリンクを張る
# ============================================================

set -euo pipefail

# このスクリプトが置かれているディレクトリを dotfiles のルートとする
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOME_DIR="$HOME"

# ---- 色定義 ----
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
RESET='\033[0m'

# ---- ログ関数 ----
info()    { echo -e "${CYAN}[info]${RESET}  $*"; }
success() { echo -e "${GREEN}[ok]${RESET}    $*"; }
warn()    { echo -e "${YELLOW}[warn]${RESET}  $*"; }
error()   { echo -e "${RED}[error]${RESET} $*" >&2; }

# ---- シンボリックリンク作成関数 ----
# 引数: <dotfiles 内のファイル名>
link_file() {
    local filename="$1"
    local src="${DOTFILES_DIR}/${filename}"
    local dest="${HOME_DIR}/${filename}"

    # リンク元が存在しない場合はスキップ
    if [ ! -e "$src" ]; then
        warn "見つからないためスキップ: ${src}"
        return
    fi

    # すでに同じシンボリックリンクが張られていればスキップ
    if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
        info "すでにリンク済み: ${dest}"
        return
    fi

    # 既存ファイル（または別のシンボリックリンク）はバックアップ
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        local backup="${dest}.bak"
        warn "既存ファイルをバックアップ: ${dest} → ${backup}"
        mv "$dest" "$backup"
    fi

    # シンボリックリンクを作成する
    ln -s "$src" "$dest"
    success "リンク作成: ${dest} → ${src}"
}

# ============================================================
# リンク対象ファイルを列挙する
# ============================================================
echo ""
echo -e "${CYAN}========================================"
echo -e " dotfiles インストール開始"
echo -e " dotfiles: ${DOTFILES_DIR}"
echo -e "========================================${RESET}"
echo ""

# シェル設定
link_file ".bashrc"
link_file ".bashrc_prompt"

# Git 設定
link_file ".gitconfig"
link_file ".gitignore_global"

# Readline 設定
link_file ".inputrc"

# エディタ共通設定
# ※ .editorconfig はプロジェクトルートに置くのが本来の用途だが、
#    ホームに置くことでサブディレクトリ全体に効かせることもできる
link_file ".editorconfig"

# Claude Code グローバル設定
link_file ".claude/CLAUDE.md"
link_file ".claude/persona.md"
link_file ".claude/settings.json"

echo ""
echo -e "${GREEN}========================================"
echo -e " 完了！"
echo -e "========================================${RESET}"
echo ""
echo "シェルに反映するには以下を実行してください:"
echo "  source ~/.bashrc"
echo ""
