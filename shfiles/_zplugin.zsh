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

# =================== remote plugins =====================

zpl ice svn has'git'
zpl snippet OMZ::plugins/git 

zpl ice svn
zpl snippet OMZ::plugins/colored-man-pages

zpl ice pick'init.sh'
zpl light b4b4r07/enhancd

zpl light zdharma/fast-syntax-highlighting

zpl ice blockf
zpl light zsh-users/zsh-completions

zpl light bric3/nice-exit-code

zpl light chisui/zsh-nix-shell

# zplug "zsh-users/zsh-syntax-highlighting"
# zplug "zsh-users/zsh-history-substring-search"
# zplug "k4rthik/git-cal", as:command, frozen:1
# zplug "b4b4r07/enhancd", use:init.sh

# =================== local files =====================

__zplex_loadFile() {
  local sourceFile="$1"
  local wait="$2"

  # if plugin installed before
  if (zpl cd "$sourceFile" > /dev/null); then
    local pluginFolder=$(zpl cd "$sourceFile" > /dev/null && pwd)
    local sourceFileBaseName=$(basename "$sourceFile")

    if ! cmp -s "$sourceFile" "$pluginFolder/$sourceFileBaseName"; then
      zpl update "$file"
    fi
  fi

  zpl ice wait"$wait" lucid
  zpl snippet "$file"
}

for file in "$SHF_ROOT"/[^_]*.zsh*; do
  __zplex_loadFile "$file"
done

for file in "$SHF_ROOT"/plugins/[^_]*.zsh*; do
  __zplex_loadFile "$file" 1
done

unset -f __zplex_loadFile
