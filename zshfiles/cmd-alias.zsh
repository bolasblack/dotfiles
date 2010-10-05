# -*- shell-script -*-
####################################### S* 自定义命令与别名

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

# cdaxel = cd ~/下载/ && axel
cdaxel() {
	cd ~/下载/;
	axel "$@";
}

mkinstl() {
	sudo make && sudo make install;
}

#命令别名
#alias cd=cdl
#alias axel=cdaxel
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias ls='ls -F --color=auto'
alias ll='ls -l'
alias grep='grep --color=auto'

####################################### E* 自定义命令与别名
