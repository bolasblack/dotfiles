# -*- shell-script -*-
function cl() {
  cd $1
  ls
}

# 查询维基百科
function wiki() {
  dig +short txt ${1}.wp.dg.cx
}

# 查询 Gmail 的未读邮件，记得在命令前加空格
function gmail() {
  curl -u ${1}@gmail.com:${2} --silent "https://mail.google.com/mail/feed/atom" | tr -d '\n' | awk -F '<entry>' '{for (i=2; i<=NF; i++) {print $i}}' | perl -pe 's/^<title>(.*)<\/title>.*<name>(.*)<\/name>.*$/$2 - $1/'
}

# 查询 commandlinefu.com
function cmdfu() {
  if [ "$1" = "byVote" ] ; then
    local query="browse/sort-by-votes"
  else
    local query="matching/$@/$(echo -n $@ | openssl base64)"
  fi
  curl "http://www.commandlinefu.com/commands/$query/plaintext";
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

alias zh='export LANG=zh_CN.UTF-8'
alias en='export LANG=en_US.UTF-8'

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
