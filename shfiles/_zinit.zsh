# https://github.com/zdharma/zinit

# =================== install zinit =====================

ZINIT_HOME="${ZINIT_HOME:-${ZDOTDIR:-$HOME}/.zinit}"
ZINIT_BIN_DIR_NAME="${ZINIT_BIN_DIR_NAME:-bin}"

if [ ! -d "$ZINIT_HOME" ]; then
  mkdir "$ZINIT_HOME"
  chmod go-w "$ZINIT_HOME"
fi

if [ ! -d "$ZINIT_HOME/$ZINIT_BIN_DIR_NAME/.git" ]; then
  echo ">>> Downloading zinit to $ZINIT_HOME/$ZINIT_BIN_DIR_NAME"
  git clone --depth 1 https://github.com/zdharma/zinit.git "$ZINIT_HOME/$ZINIT_BIN_DIR_NAME"
  echo ">>> Done"
fi

source "$ZINIT_HOME/$ZINIT_BIN_DIR_NAME/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# =================== load files =====================

# zinit recommended
zi for \
  zinit-zsh/z-a-patch-dl \
  zinit-zsh/z-a-as-monitor \
  zinit-zsh/z-a-bin-gem-node \

# load at init
zi for \
  depth=1 has=git svn OMZ::plugins/git \

# load later
zi wait=1 lucid for \
  bric3/nice-exit-code \
  chisui/zsh-nix-shell \
  pick=init.sh \
    b4b4r07/enhancd \
  atload='zicompinit; zicdreplay' blockf \
    zsh-users/zsh-completions \
# zdharma/history-search-multi-word  # 已经用了 fzf 了，就暂时不用了

# https://github.com/zdharma/fast-syntax-highlighting/issues/135
zi wait=1 lucid for \
  atload='FAST_HIGHLIGHT[chroma-man]=' \
  atinit='ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay' \
    zdharma/fast-syntax-highlighting

for file in "$SHF_ROOT"/[^_]*.zsh*; do
  zi ice
  zi snippet "$file"
done

for file in "$SHF_ROOT"/plugins/[^_]*.zsh*; do
  zi ice wait=1 lucid
  zi snippet "$file"
done

zi ice is-snippet lucid for \
  wait=1 as=completion blockf \
    ~/.nix-profile/share/zsh/site-functions/ \
  wait='![[ -n ${ZLAST_COMMANDS[(r)fzf*]} ]]' \
    ~/.nix-profile/share/fzf/ \
