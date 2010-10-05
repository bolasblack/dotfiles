#普通命令提示符，在控制台下可以正常显示，如需使用取消注释，并把底部有关提示符的语句注释掉
##RPROMPT='%/'
#PROMPT='%{[36m%}%n%{[35m%}@%{[34m%}%M %{[33m%}%D %T  %{[32m%}%/ 
#%{[31m%}>>%{[m%}'

dir="/home/yicuan/.zshfiles/others.zsh"
soufile () {
    if [ -f $dir ];then
	source $dir;
    fi
}

# 杂项
soufile

# 命令与别名设置
dir="/home/yicuan/.zshfiles/history.zsh"
soufile

# 历史记录设置
dir="/home/yicuan/.zshfiles/history.zsh"
soufile

# 自动补全设置
dir="/home/yicuan/.zshfiles/auto-complete.zsh"
soufile

# emacs files backup
if [ -e "~/.emacs.d/plugins/*" ]; then
    cp -Rn ~/.emacs.d/plugins/* ~/SparkleShare/dotfiles/emacs.plugins/;
fi

# zsh files backup
if [ -e "~/.zshfiles/*" ]; then
    cp -Rn ~/.zshfiles/* ~/SparkleShare/dotfiles/zshfiles/;
fi

# 超炫效果的提示符
dir="/home/yicuan/.zshfiles/themes.zsh"
soufile