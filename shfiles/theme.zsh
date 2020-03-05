# 载入 colors 模块，允许在命令提示符中使用类似 $fg[white] 的标记
autoload -U colors && colors

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

_render_git_prompt_info() {
  if git rev-parse --git-dir > /dev/null 2>&1; then
    if [[ -z $(_git_prompt_info) ]]; then
      echo "%B%{$fg[magenta]%}detached-head%{$reset_color%})%b"
    else
      echo "%B%{$fg[white]%}[%{$fg[red]%}$(_git_sha short)%{$fg[white]%}@$(_git_prompt_info)%b"
    fi
  fi
}

_render_nixshell() {
  [[ ! -n "$IN_NIX_SHELL" ]] && return

  local res=""
  if [[ -n "$NIX_SHELL_PACKAGES" ]]; then
    local packages=($NIX_SHELL_PACKAGES)
    local packageNames=""
    for package in $packages; do
      packageNames+=" ${package##*.}"
    done
    res="${packageNames:1}"
  fi

  echo "%{$fg[yellow]%}nix{$res}%{$reset_color%}"
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
zi for depth=1 romkatv/powerlevel10k

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  prompt_char
  status
  dir
  vcs
  permission
)
typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  command_execution_time  # duration of the last command
  background_jobs         # presence of background jobs
  direnv                  # direnv status (https://direnv.net/)
  asdf                    # asdf version manager (https://github.com/asdf-vm/asdf)
  virtualenv              # python virtual environment (https://docs.python.org/3/library/venv.html)
  anaconda                # conda environment (https://conda.io/)
  pyenv                   # python environment (https://github.com/pyenv/pyenv)
  goenv                   # go environment (https://github.com/syndbg/goenv)
  # nodenv                  # node.js version from nodenv (https://github.com/nodenv/nodenv)
  nvm                     # node.js version from nvm (https://github.com/nvm-sh/nvm)
  # nodeenv                 # node.js environment (https://github.com/ekalinin/nodeenv)
  # node_version            # node.js version
  go_version              # go version (https://golang.org)
  rust_version            # rustc version (https://www.rust-lang.org)
  dotnet_version          # .NET version (https://dotnet.microsoft.com)
  php_version             # php version (https://www.php.net/)
  laravel_version         # laravel php framework version (https://laravel.com/)
  java_version            # java version (https://www.java.com/)
  rbenv                   # ruby version from rbenv (https://github.com/rbenv/rbenv)
  rvm                     # ruby version from rvm (https://rvm.io)
  fvm                     # flutter version management (https://github.com/leoafarias/fvm)
  luaenv                  # lua version from luaenv (https://github.com/cehoffman/luaenv)
  jenv                    # java version from jenv (https://github.com/jenv/jenv)
  plenv                   # perl version from plenv (https://github.com/tokuhirom/plenv)
  phpenv                  # php version from phpenv (https://github.com/phpenv/phpenv)
  haskell_stack           # haskell version from stack (https://haskellstack.org/)
  kubecontext             # current kubernetes context (https://kubernetes.io/)
  terraform               # terraform workspace (https://www.terraform.io)
  aws                     # aws profile (https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html)
  aws_eb_env              # aws elastic beanstalk environment (https://aws.amazon.com/elasticbeanstalk/)
  azure                   # azure account name (https://docs.microsoft.com/en-us/cli/azure)
  gcloud                  # google cloud cli account and project (https://cloud.google.com/)
  google_app_cred         # google application credentials (https://cloud.google.com/docs/authentication/production)
  context                 # user@hostname
  nordvpn                 # nordvpn connection status, linux only (https://nordvpn.com/)
  ranger                  # ranger shell (https://github.com/ranger/ranger)
  nnn                     # nnn shell (https://github.com/jarun/nnn)
  vim_shell               # vim shell indicator (:sh)
  midnight_commander      # midnight commander shell (https://midnight-commander.org/)
  nix_shell               # nix shell (https://nixos.org/nixos/nix-pills/developing-with-nix-shell.html)
  # vpn_ip                # virtual private network indicator
  # load                  # CPU load
  # disk_usage            # disk usage
  # ram                   # free RAM
  # swap                  # used swap
  todo                    # todo items (https://github.com/todotxt/todo.txt-cli)
  timewarrior             # timewarrior tracking status (https://timewarrior.net/)
  taskwarrior             # taskwarrior task count (https://taskwarrior.org/)
  # time                  # current time
  # ip                    # ip address and bandwidth usage for a specified network interface
  # public_ip             # public IP address
  # proxy                 # system-wide http/https/ftp proxy
  # battery               # internal battery
  # wifi                  # wifi speed
  # example               # example user-defined segment (see prompt_example function below)
)

typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=255
typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_{VIINS,VICMD,VIVIS,VIOWR}_CONTENT_EXPANSION="%B>%b"

typeset -g POWERLEVEL9K_DIR_FOREGROUND=69

typeset -g POWERLEVEL9K_STATUS_ERROR=true
typeset -g POWERLEVEL9K_STATUS_ERROR{,_SIGNAL,_PIPE}_VISUAL_IDENTIFIER_EXPANSION=""

typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=same-dir

function my_git_formatter {
  typeset -g my_git_format="$(_render_git_prompt_info)"
}

function prompt_nix_shell {
  p10k segment -t "$(_render_nixshell)"
}
function instant_prompt_nix_shell {
  prompt_nix_shell
}

function prompt_permission {
  p10k segment -t '%F{white}%B%(!.#.$)%b%f'
}
function instant_prompt_permission {
  prompt_permission
}
