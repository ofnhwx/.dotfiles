# -*- mode: shell-script; coding: utf-8 -*-

# ================================================================
# env
# ================================================================

# -- options
setopt no_beep
setopt hist_ignore_space

# -- locales
export LANG=ja_JP.UTF-8
export LC_COLLATE=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8
export LC_MESSAGES=ja_JP.UTF-8
export LC_MONETARY=ja_JP.UTF-8
export LC_NUMERIC=ja_JP.UTF-8
export LC_TIME=ja_JP.UTF-8

# -- paths
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.config/composer/vendor/bin:$PATH"
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# -- others
export FZF_DEFAULT_OPTS='--height=60% --layout=reverse-list --border'

# -- WSL
uname -r | grep -i microsoft >/dev/null
if [ $? = 0 ]; then
  export GTK_IM_MODULE=fcitx
  export QT_IM_MODULE=fcitx
  export XMODIFIERS=@im=fcitx
  export DefaultIMModule=fcitx

  export DISPLAY="$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0.0"

  if ! pgrep -f ssh-agent >/dev/null; then
    ssh-agent -s > "$HOME/.ssh-agent.env"
  fi
  eval `cat "$HOME/.ssh-agent.env"` >/dev/null
fi

# ================================================================
# Zinit
# ================================================================

# -- Zinit - https://github.com/zdharma/zinit
source "$HOME/.zinit/bin/zinit.zsh"
unalias zi

zinit snippet PZT::modules/history/init.zsh

zinit light asdf-vm/asdf
zinit light zdharma/fast-syntax-highlighting
zinit light zdharma/history-search-multi-word
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light Tarrasch/zsh-bd

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=6"

# ================================================================
# utilities
# ================================================================

# -- Starship - https://starship.rs/
if (( $+commands[starship] )); then
  eval "$(starship init zsh)"
fi

# -- Zoxide - https://github.com/ajeetdsouza/zoxide
if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
fi

# ================================================================
# custom
# ================================================================

alias ll="lsd -l"

function __fzf-ghq() {
  local src=$(ghq list | fzf --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*")
  if [ -n "$src" ]; then
    BUFFER="cd $(ghq root)/$src"
    zle accept-line
  fi
  zle redisplay
}
zle -N __fzf-ghq
bindkey '^]' __fzf-ghq
