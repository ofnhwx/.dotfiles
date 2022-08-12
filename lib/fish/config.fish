# -*- mode: fish; coding: utf-8 -*-

# ================================================================
# env
# ================================================================

# -- locales
set -x LANG ja_JP.UTF-8
set -x LC_COLLATE ja_JP.UTF-8
set -x LC_CTYPE ja_JP.UTF-8
set -x LC_MESSAGES ja_JP.UTF-8
set -x LC_MONETARY ja_JP.UTF-8
set -x LC_NUMERIC ja_JP.UTF-8
set -x LC_TIME ja_JP.UTF-8

# -- paths
set GOPATH "$HOME/go"
set VOLTA_HOME "$HOME/.volta"

set PATH "$HOME/.local/bin" $PATH
set PATH "$HOME/.cargo/bin" $PATH
set PATH "$HOME/.config/composer/vendor/bin" $PATH
set PATH "$GOPATH/bin" $PATH
set PATH "$VOLTA_HOME/bin" $PATH

# -- others
set -x FZF_DEFAULT_OPTS '--height=40% --layout=reverse-list --border'

# ================================================================
# fisher
# ================================================================

# -- Changing the installation path
set -g fisher_path $__fish_config_dir/fisher
set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..-1]
set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..-1]
for file in $fisher_path/conf.d/*.fish
    builtin source $file 2> /dev/null
end

# -- Bootstrap installation
if not functions -q fisher
    curl https://git.io/fisher --create-dirs -sLo $__fish_config_dir/functions/fisher.fish
    fish -c fisher
end

# ================================================================
# utilities
# ================================================================

# -- direnv
if which direnv > /dev/null
    eval (direnv hook fish)
end

# -- starship
if which starship > /dev/null
    # curl -fsSL https://starship.rs/install.sh | bash
    starship init fish | source
end

# -- zoxide
if which zoxide > /dev/null
    zoxide init fish | source
end

# ================================================================
# WSL
# ================================================================
if uname -r | grep -i microsoft > /dev/null
    export GTK_IM_MODULE=fcitx
    export QT_IM_MODULE=fcitx
    export XMODIFIERS=@im=fcitx
    export DefaultIMModule=fcitx
    export DISPLAY=(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0.0

    if not pgrep -f ssh-agent
        ssh-agent -c > "$HOME/.ssh-agent.env"
    end
    eval (cat "$HOME/.ssh-agent.env") > /dev/null
end
