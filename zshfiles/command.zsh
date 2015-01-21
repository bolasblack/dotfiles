# 计算器
function qbc() {
  echo "$@" | bc
}

# 查询维基百科
function wiki() {
  dig +short txt ${1}.wp.dg.cx
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

# 列出 Git 管理的目录下所有发生过改动的文件，使用方法：
#   chdfiles 2 # 文件下标（从 1 开始，默认为 1）
#   chdfiles a # 列出所有文件
function chdfiles() {
    files=$(git status -s | cut -c 4-)
    [ "$1" = "" ] && 1="1"

    if [ "$1" = "a" ] ; then
        echo $files
    else
        echo $files | xargs | cut -d ' ' -f $1
    fi
}

function _ssh-copy-id() {
  cat ~/.ssh/id_rsa.pub | ssh $1 "[ -d ~/.ssh ] || mkdir ~/.ssh; cat >> ~/.ssh/authorized_keys"
}
# http://stackoverflow.com/questions/592620/check-if-a-program-exists-from-a-bash-script
hash ssh-copy-id 2>/dev/null || { alias ssh-copy-id='_ssh-copy-id' }

function timeconv { date -d @$1 +"%Y-%m-%d %T" }

function cl() {
  cd $1
  ls
}

function gi() {
  curl -L -s https://www.gitignore.io/api/$@
}

# 历史命令 top10
alias top10='print -l  ${(o)history%% *} | uniq -c | sort -nr | head -n 10'

# Print all 256 colors for testing TERM or for a quick reference
alias color256='( x=`tput op` y=`printf %$((${COLUMNS}-6))s`;for i in {0..256};do o=00$i;echo -e ${o:${#o}-3:3} `tput setaf $i;tput setab $i`${y// /=}$x;done; )'

alias ls='ls --color=auto'
alias lsa='ls -lah'
alias l='ls -la'
alias ll='ls -l'
alias la='ls -lA'
alias sl=ls # often screw this up
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias grep='grep --color=auto'

if [ `uname` = 'Linux' ]; then
  alias swapcaps='setxkbmap -option ctrl:swapcaps'
  alias startx='startx > ~/.log/x.log &'
  alias zhcon='zhcon --utf8'
  alias closeLCD='xset dpms force off'
fi
