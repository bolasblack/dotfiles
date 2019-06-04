# https://github.com/zdharma/zplugin

# =================== prepare =====================

if [ -z "$ZPLG_HOME" ]; then
  ZPLG_HOME="${ZDOTDIR:-$HOME}/.zplugin"
fi

if [ ! -d "$ZPLG_HOME" ]; then
  mkdir "$ZPLG_HOME"
  chmod g-rwX "$ZPLG_HOME"
fi

if [ ! -d "$ZPLG_HOME/bin/.git" ]; then
  echo ">>> Downloading zplugin to $ZPLG_HOME/bin"
  cd "$ZPLG_HOME"
  git clone --depth 10 https://github.com/zdharma/zplugin.git bin
  echo ">>> Done"
fi

source "$ZPLG_HOME/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

# =================== plugins =====================

zpl ice svn has'git'
zpl snippet OMZ::plugins/git 

zpl ice svn
zpl snippet OMZ::plugins/colored-man-pages

zpl ice pick'init.sh'
zpl light b4b4r07/enhancd

zpl light zdharma/fast-syntax-highlighting

zplg ice blockf
zpl light zsh-users/zsh-completions

zpl light bric3/nice-exit-code

zpl light chisui/zsh-nix-shell

# zplug "zsh-users/zsh-syntax-highlighting"
# zplug "zsh-users/zsh-history-substring-search"
# zplug "k4rthik/git-cal", as:command, frozen:1
# zplug "b4b4r07/enhancd", use:init.sh
