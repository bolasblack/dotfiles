# -*- shell-script -*-
####################################### S* �Զ������������

# cdl= cd && ls
cdl() {
	cd "$@";
	ls ;
}

# mkcd = mkdir && cd
mkrcd() {
	mkdir "$@";
	cd "$@";
}

# cdaxel = cd ~/����/ && axel
cdaxel() {
	cd ~/����/;
	axel "$@";
}

mkinstl() {
	sudo make && sudo make install;
}

#�������
#alias cd=cdl
#alias axel=cdaxel
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias ls='ls -F --color=auto'
alias ll='ls -l'
alias grep='grep --color=auto'

####################################### E* �Զ������������
