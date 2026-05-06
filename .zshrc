# ============================================================
# ~/.zshrc
# Mac 用インタラクティブシェル設定
# ~/.bashrc の zsh 版
# ============================================================

# ============================================================
# ヒストリ設定
# ============================================================

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=20000

setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# ============================================================
# シェルオプション
# ============================================================

# vi モード
bindkey -v

# カーソル形状をモードで切り替え（挿入=バー、ノーマル=ブロック）
function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]]; then
        echo -ne '\e[2 q'
    else
        echo -ne '\e[6 q'
    fi
}
zle -N zle-keymap-select

function zle-line-init {
    echo -ne '\e[6 q'
}
zle -N zle-line-init

# ============================================================
# 色設定
# ============================================================

# macOS の BSD ls はカラーに -G フラグを使う
export CLICOLOR=1
alias ls='ls -G'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# ============================================================
# エイリアス
# ============================================================

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# ============================================================
# 補完
# ============================================================

if type brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

autoload -Uz compinit && compinit

# ============================================================
# 外部エイリアス定義ファイル
# ============================================================

if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi

# ============================================================
# プロンプト設定
# ============================================================

setopt PROMPT_SUBST

if [ -f ~/.zshrc_prompt ]; then
    . ~/.zshrc_prompt
fi

# ============================================================
# 環境変数
# ============================================================

export EDITOR=vim

# ============================================================
# PATH 設定
# ============================================================

export PATH="$HOME/.local/bin:$PATH"

# .NET SDK
export PATH="$PATH:$HOME/.dotnet"

# Homebrew
if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

# ============================================================
# ツール別の設定
# ============================================================

# --- Node.js (nvm) ---
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ]          && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# --- Google Cloud SDK ---
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then
    . "$HOME/google-cloud-sdk/path.zsh.inc"
fi
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then
    . "$HOME/google-cloud-sdk/completion.zsh.inc"
fi

# --- SSH Agent 自動起動 ---
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" > /dev/null
    ssh-add --apple-use-keychain ~/.ssh/id_ed25519 2>/dev/null
fi

# --- direnv フック ---
eval "$(direnv hook zsh)"
