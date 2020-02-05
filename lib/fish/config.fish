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

# Android
if [ -d "$HOME/Library/Android/sdk" ]
  set -x ANDROID_SDK_ROOT "$HOME/Library/Android/sdk"
  set PATH "$ANDROID_SDK_ROOT/platform-tools" $PATH
end

# anyenv
set PATH "$HOME/.anyenv/bin" $PATH
status --is-interactive; and source (anyenv init -|psub)
# https://github.com/rbenv/ruby-build/issues/1085#issuecomment-313604449
switch (uname)
case Darwin
  set -x RUBY_CONFIGURE_OPTS --with-openssl-dir=/opt/local/
end

# add other paths
set PATH "$HOME/go/bin" $PATH
set PATH "/usr/local/sbin" $PATH
set GHQ_ROOT (ghq root)
set PATH "$GHQ_ROOT/github.com/gauteh/lieer" $PATH
set PATH "$GHQ_ROOT/github.com/junegunn/fzf/bin" $PATH

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
  alias emacs  '/usr/bin/emacs & disown'
  alias e      '/usr/bin/emacsclient'
  alias idea   '/usr/local/bin/idea   & disown'
  alias pstorm '/usr/local/bin/pstorm & disown'
  alias mine   '/usr/local/bin/mine   & disown'
  alias clion  '/usr/local/bin/clion  & disown'
  export GTK_IM_MODULE=fcitx
  export QT_IM_MODULE=fcitx
  export XMODIFIERS=@im=fcitx
  export DefaultIMModule=fcitx
  export DISPLAY=:0
end
