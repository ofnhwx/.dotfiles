# -*- mode: conf-space; coding: utf-8 -*-
# Last updated: <2017/12/01 17:11:28>

# Locale
set -x LANG ja_JP.UTF-8
set -x LC_COLLATE ja_JP.UTF-8
set -x LC_CTYPE ja_JP.UTF-8
set -x LC_MESSAGES ja_JP.UTF-8
set -x LC_MONETARY ja_JP.UTF-8
set -x LC_NUMERIC ja_JP.UTF-8
set -x LC_TIME ja_JP.UTF-8

# Notmuch
set -x XAPIAN_CJK_NGRAM 1

# anyenv
set PATH "$HOME/.anyenv/bin" $PATH
status --is-interactive; and source (anyenv init -|psub)
# https://github.com/rbenv/ruby-build/issues/1085#issuecomment-313604449
switch (uname)
case Darwin
  set -x RUBY_CONFIGURE_OPTS --with-openssl-dir=/opt/local/
end

# go
set PATH "$GOPATH/bin" $PATH

# ghq
set -x GHQROOT (ghq root)
set PATH "$GHQROOT/github.com/gauteh/lieer" $PATH
set PATH "$GHQROOT/github.com/junegunn/fzf/bin" $PATH

# keybind
function fish_user_key_bindings
  bind \c] '__ghq_repository_search'
  bind \ct '__fzf_find_file'
  bind \cr '__fzf_reverse_isearch'
  bind \ec '__fzf_cd'
  bind \eC '__fzf_cd --hidden'
  bind \cg '__fzf_open'
  bind \co '__fzf_open --editor'
end

# WSL
if uname -r | grep Microsoft > /dev/null
  export GTK_IM_MODULE=fcitx
  export QT_IM_MODULE=fcitx
  export XMODIFIERS=@im=fcitx
  export DefaultIMModule=fcitx
  export DISPLAY=:0
end
