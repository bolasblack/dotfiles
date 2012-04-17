ZSHFILES=$HOME/.zshfiles

#设置默认编码
export LANG=zh_CN.UTF-8

#设置默认编辑器，打命令的时候试试 C-x C-e
export EDITOR=vim

#允许在交互模式中使用注释  例如：
#cmd #这是注释
setopt INTERACTIVE_COMMENTS      
      
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

zstyle ':completion:*:ping:*' hosts 129.27.2.3 www.tugraz.at \
       10.16.17.1{{7..9},}

source $ZSHFILES/zhyana.zsh
source $ZSHFILES/alias.zsh
source $ZSHFILES/key-bindings.zsh
source $ZSHFILES/autoComplete.zsh
source $ZSHFILES/history.zsh

# vim:filetype=zsh expandtab shiftwidth=4
