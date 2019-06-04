# code from https://github.com/Kasahs/.znvm/

# The commands in the ZNVM_PREEXEC array when called from zsh will load nvm first
# Add/remove items from the list of commands given below
ZNVM_PREEXEC=("code")




znvm_nvm_loaded() {
  [[ $(command -v nvm) == "nvm" ]]
}




znvm_load_nvm() {
	# if nvm command is present nvm is ready no need to load
	if ! znvm_nvm_loaded; then
		# unalias nvm if alias exists
		[ `alias | grep nvm | wc -l` != 0 ] && unalias nvm

		echo "loading nvm..."
		[ -z $NVM_DIR ] && export NVM_DIR="$HOME/.nvm"
		[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
		[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
	fi
}

znvm_run_nvm() {
  znvm_load_nvm
  nvm $@
}
alias nvm='znvm_run_nvm'




znvm_echo() {
  command printf %s\\n "$*" 2>/dev/null || {
    znvm_echo() {
      # shellcheck disable=SC1001
      \printf %s\\n "$*" # on zsh, `command printf` sometimes fails
    }
    znvm_echo "$@"
  }
}

znvm_find_up() {
  local path
  path="${PWD}"
  while [ "${path}" != "" ] && [ ! -f "${path}/${1-}" ]; do
    path=${path%/*}
  done
  znvm_echo "${path}"
}

znvm_find_nvmrc() {
  local dir
  dir="$(znvm_find_up '.nvmrc')"
  if [ -e "${dir}/.nvmrc" ]; then
    znvm_echo "${dir}/.nvmrc"
  fi
}

autoload -U add-zsh-hook
znvm_load_by_nvmrc() {
  if [ -n "$(znvm_find_nvmrc)" ]; then
    nvm use
  fi
}
add-zsh-hook chpwd znvm_load_by_nvmrc




znvm_contains_elem () {
  local e match="$1"
  shift
  for e; do [[ "$match" =~ "^\ *$e\ +.*" ]] && return 0; done
  return 1
}

znvm_load_pre_exec () {
 	if znvm_contains_elem "$1" "${ZNVM_PREEXEC[@]}"; then
 		znvm_load_nvm
	fi
}
add-zsh-hook preexec znvm_load_pre_exec
