# Emacs 风格 键绑定
bindkey -e

# [Esc][h] man 当前命令时，显示简短说明
alias run-help >&/dev/null && unalias run-help
autoload run-help

# 空行（光标在行首）补全 cd
cd-complete() {
  if [[ ! -n $BUFFER ]] ; then
    BUFFER="cd "
    zle end-of-line
  fi
  zle expand-or-complete
}
zle -N cd-complete
bindkey "\t" cd-complete

# 在命令前插入 sudo
sudo-command-line() {
  [[ -z $BUFFER ]] && zle up-history
  [[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
  #光标移动到行末
  zle end-of-line
}
zle -N sudo-command-line
# 定义快捷键为： [Esc] [Esc]
bindkey "\e\e" sudo-command-line

autoload edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# 设置 [DEL]键 为向后删除
bindkey "\e[3~" delete-char