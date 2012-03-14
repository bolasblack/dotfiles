# -*- shell-script -*-
function cl() {
    cd $1
    ls
}

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias ll='ls -l'
alias la='ls -A'
alias grep='grep --color=auto'
alias fehbg="feh --bg-scale"
alias mkinstl="make && sudo make install"
alias swapcaps='setxkbmap -option ctrl:swapcaps'
alias startx='startx > ~/.log/x.log &'
alias zhcon='zhcon --utf8'
alias dellonly='xrandr --output VGA-1 --auto --output LVDS-1 --off'
alias closeLCD='xset dpms force off'
alias gitflow='git flow'

alias connSSH='ssh -qTfnN -D 7070'

#[Esc][h] man 当前命令时，显示简短说明 
alias run-help >&/dev/null && unalias run-help
autoload run-help

#历史命令 top10
alias top10='print -l  ${(o)history%% *} | uniq -c | sort -nr | head -n 10'

#路径别名 
#进入相应的路径时只要 cd ~xxx
hash -d WWW="/home/lighttpd/html"
hash -d ARCH="/mnt/arch"
hash -d PKG="/var/cache/pacman/pkg"
hash -d E="/etc/env.d"
hash -d C="/etc/conf.d"
hash -d I="/etc/rc.d"
hash -d X="/etc/X11"
hash -d BK="/home/r00t/config_bak"

# vim:filetype=zsh expandtab shiftwidth=4
