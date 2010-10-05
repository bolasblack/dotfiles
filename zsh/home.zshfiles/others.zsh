# -*- shell-script -*-
####################################### S* ����
#��չ·��
#/v/c/p/p => /var/cache/pacman/pkg
setopt complete_in_word

#Disable core dumps
limit coredumpsize 0

#Emacs������
bindkey -e
#����DEL��Ϊ���ɾ��
bindkey "\e[3~" delete-char

#�����ַ���Ϊ���ʵ�һ����
WORDCHARS='*?_-[]~=&;!#$%^(){}<>'

#·������ ������Ӧ��·��ʱֻҪ cd ~xxx
#ʾ���� hash -d WWW="/home/lighttpd/html"

##for Emacs��Emacs�ն���ʹ��Zsh��һЩ���� ���Ƽ���Emacs��ʹ����
if [[ "$TERM" == "dumb" ]]; then
setopt No_zle
PROMPT='%n@%M %/
>>'
alias ls='ls -F'
fi

##������ǰ���� notify sudo
#���幦�� 
notify-sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    [[ $BUFFER != "notify sudo \*" ]] && BUFFER="notify sudo $BUFFER"
    zle end-of-line                 #����ƶ�����ĩ
}
zle -N notify-sudo-command-line
#�����ݼ�Ϊ�� [Esc] [Esc] [Esc]
bindkey "\e\e\e" notify-sudo-command-line

##������ǰ���� notify
#���幦�� 
notify-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    [[ $BUFFER != notify\ * ]] && BUFFER="notify $BUFFER"
    zle end-of-line                 #����ƶ�����ĩ
}
zle -N notify-command-line
#�����ݼ�Ϊ�� [Esc] [Esc]
bindkey "\e\e" notify-command-line

##ƴ����ȫ
#���幦��
function pycomple() { 
	reply=($($HOME/.chs_comple/chsdir 0 $*));
}
#�����ݼ�
bindkey -s "\C-y" "fg\n"
zstyle ':completion:*' user-expand pycomple

#�Զ���� $PATH
export PATH="$PATH:/home/yicuan/.personal-scripts/"

####################################### E* ����
