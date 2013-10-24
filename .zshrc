# -*- shell-script -*-
#
# optional:
#   autojump <https://github.com/joelthelion/autojump>
#   git-flow-avh <https://github.com/petervanderdoes/gitflow>
#
#[[[ oh-my-zsh 
# Path to your oh-my-zsh configuration.
ZSH=$HOME/dotfiles/oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git git-flow github
         archlinux brew osx
         python pip
         npm node coffee cake bower
         gem rails3 rails4 rake ruby rvm
         autojump tmux web-search)

source $ZSH/oh-my-zsh.sh
#]]]
#[[[ base
export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

# coreutils setting [[[
export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
# ]]]

[ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && source "$HOME/.scm_breeze/scm_breeze.sh"

#设置默认编码
export LANG=zh_CN.UTF-8

#设置默认编辑器，打命令的时候试试 C-x C-e
export EDITOR=vim

#允许在交互模式中使用注释  例如：
#cmd #这是注释
setopt INTERACTIVE_COMMENTS

if [[ -s $HOME"/.rvm/scripts/rvm" ]]; then
  export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
  source $HOME"/.rvm/scripts/rvm"
fi

#启用自动 cd，输入目录名回车进入目录
#稍微有点混乱，不如 cd 补全实用
setopt AUTO_CD

#禁用 core dumps
limit coredumpsize 0

#以下字符视为单词的一部分
WORDCHARS='*?_-[]~=&;!#$%^(){}<>'

##for Emacs 
#在 Emacs终端 中使用 Zsh 的一些设置 不推荐在 Emacs 中使用它
if [[ "$TERM" == "dumb" ]]; then
  setopt No_zle
  PROMPT='%n@%M %/
  >>'
  alias ls='ls -F'
fi

function timeconv { date -d @$1 +"%Y-%m-%d %T" }
#]]]
#[[[ alias
function cl() {
  cd $1
  ls
}

# 计算器
function qbc() {
  echo "$@" | bc
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

alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -A'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias grep='grep --color=auto'
alias swapcaps='setxkbmap -option ctrl:swapcaps'
alias startx='startx > ~/.log/x.log &'
alias zhcon='zhcon --utf8'
alias closeLCD='xset dpms force off'

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
#]]]
#[[[ key binding
##行编辑高亮模式
# Ctrl+@ 设置标记，标记和光标点之间为 region
zle_highlight=(region:bg=magenta #选中区域 
               special:bold      #特殊字符
               isearch:underline)#搜索时使用的关键字

##空行(光标在行首)补全 cd
user-complete(){
    if [[ -n $BUFFER ]] ; then
        zle expand-or-complete
    else
        BUFFER="cd "
        zle end-of-line
        zle expand-or-complete
    fi }
zle -N user-complete
bindkey "\t" user-complete

##在命令前插入 sudo
#定义功能 
sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    [[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
    #光标移动到行末
    zle end-of-line
}
zle -N sudo-command-line

#定义快捷键为： [Esc] [Esc]
bindkey "\e\e" sudo-command-line

#Emacs风格 键绑定
bindkey -e
#设置 [DEL]键 为向后删除
bindkey "\e[3~" delete-char
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^F" forward-char
bindkey "^B" backward-char
#]]]
#[[[ history
#历史纪录条目数量
export HISTSIZE=10000
#注销后保存的历史纪录条目数量
export SAVEHIST=10000

# 定义函数，替换原来的 cd 
cd() {
    builtin cd "$@"                             # 执行原来的 cd 命令
    fc -W                                       # 写历史纪录文件，默认参数为 $HISTFILE 。初始值为 #2 处的定义；执行了 cd 命令后为 #1 处的定义
    # 实际上，你不可能在每个目录下都执行个把命令，很多目录你没有去过，只要为你去过的目录建立历史纪录就可以了
    local HISTDIR="$HOME/.zsh_history$PWD"      # 定义历史纪录目录。每次 cd 后，$PWD 对应与工作目录层级相同的目录
        if  [ ! -d "$HISTDIR" ] ; then          # 如果不存在这个目录，则建立一个
            mkdir -p "$HISTDIR"
        fi
        export HISTFILE="$HISTDIR/zhistory"     #1 定义历史纪录文件  
    touch $HISTFILE                             # 先 touch 一下，如果不存在的话就会新建一个
    # 清空原来的历史纪录
    local ohistsize=$HISTSIZE                   # 设定一个变量临时存储原历史纪录大小
        HISTSIZE=0                              # 通过禁用历史纪录清空
        HISTSIZE=$ohistsize                     # 重新设定历史纪录大小
    fc -R                                       #读历史纪录文件，默认参数为 $HISTFILE  。也就是 #1 处的定义
}
# 启动 zsh 的时候，并没有执行 cd 命令，因此 $HOME 目录对应的历史纪录目录可能不存在，先建立它
mkdir -p $HOME/.zsh_history$PWD
#2 同样，启动 zsh 的时候， 还没有定义 $HOME 目录对应的 $HISTFILE ，所以先定义它
export HISTFILE="$HOME/.zsh_history$PWD/zhistory"

# 使用 setopt EXTENDED_HISTORY 选项，为命令添加时间戳 
# 这非常重要，汇总到一起的历史纪录比较混乱，时间戳是重新排序的依据 

# 定义 allhistory ，将所有的历史纪录汇总到一起
function allhistory { cat $(find $HOME/.zsh_history -name zhistory) }
# 针对历史纪录的格式进行转换
function convhistory {
    sort $1 |      #排序
    uniq |        #合并相同行。
                    #由于时间戳精确到秒，所以几乎不可能有相同的纪录
                    #出现相同的纪录是因为 zsh 的处理方式，每次 cd 会在两个纪录文件中产生相同的 cd 命令
    sed 's/^:\([ 0-9]*\):[0-9]*;\(.*\)/\1::::::\2/' |   #去掉历史纪录中不需要的字段。添加自定义的分隔符，方便下一步处理
    awk -F"::::::" '{ $1=strftime("%Y-%m-%d %T",$1) "|"; print }'    # 将 UNIX 时间戳转换成可以看懂的格式
}

#使用 histall 命令查看全部历史纪录
function histall { convhistory =(allhistory) | sed '/^.\{20\} *cd/i\\' }  # 在每个 cd 命令前添加空行，判断工作目录比较容易 
# 可能会有一点不准确。因为启动和退出时不执行 cd 命令，没有相应的纪录。尤其是同时运行多个 zsh  的时候
#使用 hist 查看当前目录历史纪录
function hist { convhistory $HISTFILE }
#]]]
#[[[ auto complete
setopt AUTO_LIST
setopt AUTO_MENU
#开启此选项，补全时会直接选中菜单项
setopt MENU_COMPLETE

autoload -U compinit
compinit

#自动补全缓存
#zstyle ':completion::complete:*' use-cache on
#zstyle ':completion::complete:*' cache-path .zcache
#zstyle ':completion:*:cd:*' ignore-parents parent pwd

#自动补全选项
zstyle ':completion:*:match:*' original only
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:predict:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:*' completer _complete _prefix _correct _prefix _match _approximate

#路径补全
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-shlashes 'yes'
zstyle ':completion::complete:*' '\\'

zstyle ':completion:*' menu select
zstyle ':completion:*:*:default' force-list always

#彩色补全菜单 
eval $(dircolors -b) 
export ZLSCOLORS="${LS_COLORS}"
zmodload zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

#错误校正
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

#kill 命令补全
compdef pkill=kill
compdef pkill=killall
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:processes' command 'ps -au$USER'

#补全类型提示分组
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d --\e[0m'
zstyle ':completion:*:messages' format $'\e[01;35m -- %d --\e[0m'
zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found --\e[0m'
#]]]
#[[[ theme (based oh-my-zsh)
PROMPT='%B>%(0?.. %{$fg[red]%}%?) %{$fg[blue]%}%~$(check_git_prompt_info) %{$fg[white]%}%(!.#.$) %b%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[white]%}] %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[white]%}]"

function check_git_prompt_info() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        if [[ -z $(git_prompt_info) ]]; then
            echo " %{$fg[magenta]%}detached-head%{$reset_color%})"
        else
            echo " %{$fg[white]%}[%{$fg[red]%}$(git_prompt_short_sha)%{$fg[white]%}@$(git_prompt_info)"
        fi
    fi
}
#]]]
# [[[ plugins
if [ -e $HOME/.zshfiles ]; then
  if [ `ls $HOME/.zshfiles/ | grep -c "[^disabled]"` -gt 0 ]; then
    source $HOME/.zshfiles/*[!disabled]
  fi
fi
# ]]]
# vim:fileencoding=utf-8 filetype=zsh expandtab shiftwidth=2

