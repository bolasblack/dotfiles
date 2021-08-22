cmd_exist() {
  # http://stackoverflow.com/questions/592620/check-if-a-program-exists-from-a-bash-script
  hash "$1" 2>/dev/null
}

# 计算器
qbc() {
  echo "$@" | bc
}

# 查询维基百科
wiki() {
  dig +short txt ${1}.wp.dg.cx
}

# 查询 commandlinefu.com
cmdfu() {
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
chdfiles() {
  files=$(git status -s | cut -c 4-)
  [ "$1" = "" ] && 1="1"

  if [ "$1" = "a" ] ; then
    echo $files
  else
    echo $files | xargs | cut -d ' ' -f $1
  fi
}

_fzf_git_checkout() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" | fzf-tmux -d $(( 2 + $(wc -l <<< "$branches"))) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}
cmd_exist fzf-tmux && alias gco='_fzf_git_checkout'
cmd_exist fzf-tmux && alias fzf-git-checkout='_fzf_git_checkout'

_ssh_copy_id() {
  cat ~/.ssh/id_rsa.pub | ssh $1 "[ -d ~/.ssh ] || mkdir ~/.ssh; cat >> ~/.ssh/authorized_keys"
}
# http://stackoverflow.com/questions/592620/check-if-a-program-exists-from-a-bash-script
cmd_exist ssh-copy-id || alias ssh-copy-id='_ssh_copy_id'

timeconv() {
  date -d @$1 +"%Y-%m-%d %T"
}

gi() {
  curl -L -s https://www.gitignore.io/api/$@
}

# 历史命令 top10
alias top10='print -l  ${(o)history%% *} | uniq -c | sort -nr | head -n 10'

# Print all 256 colors for testing TERM or for a quick reference
alias color256='( x=`tput op` y=`printf %$((${COLUMNS}-6))s`;for i in {0..256};do o=00$i;echo -e ${o:${#o}-3:3} `tput setaf $i;tput setab $i`${y// /=}$x;done; )'

alias sl=ls # often screw this up
alias ls='ls --color=auto'
alias lsa='ls -lah'
alias l='ls -la'
alias ll='ls -l'
alias la='ls -lA'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias grep='grep --color=auto'
alias unverified-ssh='ssh -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null"'
alias .cd='dirs -pl | fzf | cd'
alias .dir='basename `pwd`'

if [ `uname` = 'Linux' ]; then
  alias swapcaps='setxkbmap -option ctrl:swapcaps'
  alias startx='startx > ~/.log/x.log &'
  alias zhcon='zhcon --utf8'
  alias closeLCD='xset dpms force off'
fi

if cmd_exist bat; then
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi
