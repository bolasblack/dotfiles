# -*- shell-script -*-
####################################### S* 杂项
#扩展路径
#/v/c/p/p => /var/cache/pacman/pkg
setopt complete_in_word

#Disable core dumps
limit coredumpsize 0

#Emacs风格键绑定
bindkey -e
#设置DEL键为向后删除
bindkey "\e[3~" delete-char

#以下字符视为单词的一部分
WORDCHARS='*?_-[]~=&;!#$%^(){}<>'

#路径别名 进入相应的路径时只要 cd ~xxx
#示例： hash -d WWW="/home/lighttpd/html"

##for Emacs在Emacs终端中使用Zsh的一些设置 不推荐在Emacs中使用它
if [[ "$TERM" == "dumb" ]]; then
setopt No_zle
PROMPT='%n@%M %/
>>'
alias ls='ls -F'
fi

##在命令前插入 notify sudo
#定义功能 
notify-sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    [[ $BUFFER != "notify sudo \*" ]] && BUFFER="notify sudo $BUFFER"
    zle end-of-line                 #光标移动到行末
}
zle -N notify-sudo-command-line
#定义快捷键为： [Esc] [Esc] [Esc]
bindkey "\e\e\e" notify-sudo-command-line

##在命令前插入 notify
#定义功能 
notify-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    [[ $BUFFER != notify\ * ]] && BUFFER="notify $BUFFER"
    zle end-of-line                 #光标移动到行末
}
zle -N notify-command-line
#定义快捷键为： [Esc] [Esc]
bindkey "\e\e" notify-command-line

##拼音补全
#定义功能
function pycomple() { 
	reply=($($HOME/.chs_comple/chsdir 0 $*));
}
#定义快捷键
bindkey -s "\C-y" "fg\n"
zstyle ':completion:*' user-expand pycomple

#自定义的 $PATH
export PATH="$PATH:/home/yicuan/.personal-scripts/"

####################################### E* 杂项
