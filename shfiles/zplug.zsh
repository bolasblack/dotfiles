# https://github.com/zplug/zplug

export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "plugins/git", from:oh-my-zsh, if:"(( $+commands[git] ))"
zplug "plugins/colored-man-pages", from:oh-my-zsh
# zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-completions"
zplug "zdharma/fast-syntax-highlighting"
# zplug "zsh-users/zsh-history-substring-search"
# zplug "k4rthik/git-cal", as:command, frozen:1
# zplug "b4b4r07/enhancd", use:init.sh
zplug "bric3/nice-exit-code"
zplug "chisui/zsh-nix-shell", use:nix-shell.plugin.zsh

export ENHANCD_FILTER="/usr/local/bin/fzf"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

# Then, source plugins and add commands to $PATH
zplug load
