[ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

__nvmex_echo() {
  command printf %s\\n "$*" 2>/dev/null || {
    __nvmex_echo() {
      # shellcheck disable=SC1001
      \printf %s\\n "$*" # on zsh, `command printf` sometimes fails
    }
    __nvmex_echo "$@"
  }
}

__nvmex_find_up() {
  local path
  path="${PWD}"
  while [ "${path}" != "" ] && [ ! -f "${path}/${1-}" ]; do
    path=${path%/*}
  done
  __nvmex_echo "${path}"
}

__nvmex_find_nvmrc() {
  local dir
  dir="$(__nvmex_find_up '.nvmrc')"
  if [ -e "${dir}/.nvmrc" ]; then
    __nvmex_echo "${dir}/.nvmrc"
  fi
}

autoload -U add-zsh-hook
__nvmex_load_by_nvmrc() {
  if [ -n "$(__nvmex_find_nvmrc)" ]; then
    nvm use
  fi
}
add-zsh-hook chpwd __nvmex_load_by_nvmrc
