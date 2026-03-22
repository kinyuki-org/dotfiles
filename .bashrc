# ============================================================
# ~/.bashrc
# インタラクティブシェル起動時に読み込まれる設定ファイル
# ============================================================

# 非インタラクティブシェルでは何もしない
case $- in
    *i*) ;;
      *) return;;
esac

# ============================================================
# ヒストリ設定
# ============================================================

# 重複行・空白始まりの行はヒストリに残さない
HISTCONTROL=ignoreboth

# ヒストリはファイルに追記する（上書きしない）
shopt -s histappend

# メモリ上のヒストリ件数
HISTSIZE=10000

# ファイルに保存するヒストリ件数
HISTFILESIZE=20000

# ヒストリにタイムスタンプを記録する
HISTTIMEFORMAT='%Y-%m-%d %T '

# ============================================================
# シェルオプション
# ============================================================

# ウィンドウサイズ変更時に LINES / COLUMNS を自動更新する
shopt -s checkwinsize

# ** でサブディレクトリを再帰的にマッチさせる
shopt -s globstar

# vimモード
set -o vi

# カーソル形状をモードで切り替え（挿入=バー、ノーマル=ブロック）
bind 'set show-mode-in-prompt on'
bind 'set vi-ins-mode-string "\1\e[6 q\2"'   # 挿入モード: |
bind 'set vi-cmd-mode-string "\1\e[2 q\2"'   # ノーマルモード: █

# ============================================================
# 色設定
# ============================================================

# ls / grep などのカラー表示を有効化する
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# ============================================================
# エイリアス
# ============================================================

# ls 系
alias ll='ls -alF'          # 詳細表示（隠しファイル含む）
alias la='ls -A'            # 隠しファイルも表示（. と .. は除く）
alias l='ls -CF'            # コンパクト表示

# ナビゲーション
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# 安全対策: 上書き・削除前に確認を求める
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# ============================================================
# 補完
# ============================================================

# プログラム補完を有効化する（/etc/bash.bashrc で未設定の場合）
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# ============================================================
# 外部エイリアス定義ファイル
# ============================================================

# ~/.bash_aliases が存在すれば読み込む
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# ============================================================
# プロンプト設定
# ============================================================

# プロンプトの定義は別ファイルに分離している
if [ -f ~/.bashrc_prompt ]; then
    . ~/.bashrc_prompt
fi

# ============================================================
# 環境変数
# ============================================================

# WSL: ブラウザ設定
export BROWSER=firefox

# WSL: ディスプレイ設定
# RDP/Xセッション内ではxrdpがDISPLAYを設定済みのため上書きしない
if [ -z "$DISPLAY" ]; then
    if [ -d /mnt/wslg ]; then
        export DISPLAY=:0
        export WAYLAND_DISPLAY=wayland-0
    else
        export DISPLAY="$(hostname).mshome.net:0.0"
    fi
fi

# エディタを vim に設定する
export EDITOR=vim

# ============================================================
# PATH 設定
# ============================================================

# ローカルバイナリを優先する
export PATH="$HOME/.local/bin:$PATH"

# .NET SDK
export PATH="$PATH:$HOME/.dotnet"

# ============================================================
# ツール別の設定
# ============================================================

# # --- Homebrew (Linuxbrew) ---
# if [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
#     eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"
# fi

# --- Node.js (nvm) ---
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ]             && \. "$NVM_DIR/nvm.sh"             # nvm 本体
[ -s "$NVM_DIR/bash_completion" ]    && \. "$NVM_DIR/bash_completion"    # nvm 補完

# # --- Google Cloud SDK ---
# if [ -f "$HOME/google-cloud-sdk/path.bash.inc" ]; then
#     . "$HOME/google-cloud-sdk/path.bash.inc"
# fi
# if [ -f "$HOME/google-cloud-sdk/completion.bash.inc" ]; then
#     . "$HOME/google-cloud-sdk/completion.bash.inc"
# fi

# --- less: バイナリファイルを見やすく表示する ---
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
