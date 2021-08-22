# 载入 colors 模块，允许在命令提示符中使用类似 $fg[white] 的标记
autoload -U colors && colors

# 每次刷新命令提示符的时候都要求重新绘制
setopt prompt_subst

# copy from oh-my-zsh https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/git.zsh

GIT_PROMPT_PREFIX="%{$fg[red]%}"
GIT_PROMPT_SUFFIX="%{$reset_color%}"
GIT_PROMPT_DIRTY="%{$fg[white]%}] %{$fg[yellow]%}✗%{$reset_color%}"
GIT_PROMPT_CLEAN="%{$fg[white]%}]"

_git_sha() {
  case $1 in
    short)
      git rev-parse --short HEAD 2> /dev/null
    ;;
    *)
      git rev-parse HEAD 2> /dev/null
    ;;
  esac
}

# Checks if working tree is dirty
_parse_git_dirty() {
  local SUBMODULE_SYNTAX=''
  local GIT_STATUS=''
  local CLEAN_MESSAGE='nothing to commit (working directory clean)'
  if [[ $POST_1_7_2_GIT -gt 0 ]]; then
        SUBMODULE_SYNTAX="--ignore-submodules=dirty"
  fi
  if [[ "$DISABLE_UNTRACKED_FILES_DIRTY" == "true" ]]; then
      GIT_STATUS=$(command git status -s ${SUBMODULE_SYNTAX} -uno 2> /dev/null | tail -n1)
  else
      GIT_STATUS=$(command git status -s ${SUBMODULE_SYNTAX} 2> /dev/null | tail -n1)
  fi
  if [[ -n $GIT_STATUS ]]; then
    echo "$GIT_PROMPT_DIRTY"
  else
    echo "$GIT_PROMPT_CLEAN"
  fi
}

_git_prompt_info() {
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(_git_sha short) || return
  echo "$GIT_PROMPT_PREFIX${ref#refs/heads/}$(_parse_git_dirty)$GIT_PROMPT_SUFFIX"
}


_check_git_prompt_info() {
  if git rev-parse --git-dir > /dev/null 2>&1; then
    if [[ -z $(_git_prompt_info) ]]; then
      echo " %{$fg[magenta]%}detached-head%{$reset_color%})"
    else
      echo " %{$fg[white]%}[%{$fg[red]%}$(_git_sha short)%{$fg[white]%}@$(_git_prompt_info)"
    fi
  fi
}

_render_hostname() {
  # for OS X
  [[ `hostname` =~ \.local$ ]] && return
  [[ `hostname` = 'localhost' ]] && return
  echo "($(hostname)) "
}

# from https://gist.github.com/chisui/0d12bd51a5fd8e6bb52e6e6a43d31d5e#file-agnoster-nix-zsh-theme-L202
_render_nixshell() {
  [[ ! -n "$IN_NIX_SHELL" ]] && return
  if [[ -n "$NIX_SHELL_PACKAGES" ]]; then
    local packages=($NIX_SHELL_PACKAGES)
    local packageNames=""
    for package in $packages; do
      packageNames+=" ${package##*.}"
    done
    echo "{$packageNames } "
  elif [[ -n $name ]]; then
    local cleanName=${name#interactive-}
    cleanName=${cleanName%-environment}
    echo "{ $cleanName } "
  else # This case is only reached if the nix-shell plugin isn't installed or failed in some way
    echo "nix-shell {} "
  fi
}

# 这里必须是单引号，双引号的话 prompt_subst 配置项就失效了
PROMPT='%{$fg[yellow]%}$(_render_nixshell)%{$fg[white]%}$(_render_hostname)%B>%(0?.. %{$fg[red]%}%?) %{$fg[blue]%}%~$(_check_git_prompt_info) %{$fg[white]%}%(!.#.$) %b%{$reset_color%}'
