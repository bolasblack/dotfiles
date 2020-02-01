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
# 定义快捷键为: [Esc] [Esc]
bindkey "\e\e" sudo-command-line

# 使用默认编辑器编辑当前命令
autoload edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# 设置 [DEL] 键 为向后删除
bindkey "\e[3~" delete-char

############ 后续都是 Emacs 风格键绑定相关的配置 #############

# Emacs 风格 键绑定
bindkey -e

# M-w 复制选中内容并取消选区，行为向 emacs 靠拢
c4-emacs-kill-ring-save() {
  zle copy-region-as-kill
  zle deactivate-region
}
zle -N c4-emacs-kill-ring-save
bindkey -e "^[w" c4-emacs-kill-ring-save

# 有选区时执行 kill-region ，否则执行 backward-kill-word
c4-emacs-smart-kill-region() {
  if [ "$REGION_ACTIVE" = "0" ]; then
    zle backward-kill-word
  else
    zle kill-region
  fi
}
zle -N c4-emacs-smart-kill-region
bindkey -e "^w" c4-emacs-smart-kill-region
