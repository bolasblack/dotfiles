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
    path="${path%/*}"
  done
  __nvmex_echo "${path}"
}

autoload -U add-zsh-hook
__nvmex_load_by_nvmrc() {
  local nvmrcPath="$(__nvmex_find_up '.nvmrc')"
  if \
    [ -n "$nvmrcPath" ] && \
    ! (node --version | grep -E "^v?$(cat "$nvmrcPath"/.nvmrc)" >/dev/null) && \
    ; then
    echo nvm use
    nvm use
  fi
}
add-zsh-hook chpwd __nvmex_load_by_nvmrc
__nvmex_load_by_nvmrc
