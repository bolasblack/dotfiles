home='/home/plafer'
soufile () {
	dir=$home$dir
    if [ -f $dir ];then
		source $dir;
    fi
}

# 杂项
dir="/.zshfiles/others.zsh"
soufile

# 命令与别名设置
dir="/.zshfiles/cmd-alias.zsh"
soufile

# 历史记录设置
dir="/.zshfiles/history.zsh"
soufile

# 自动补全设置
dir="/.zshfiles/auto-complete.zsh"
soufile

# 超炫效果的提示符
# dir="/home/yicuan/.zshfiles/themes.zsh"
# soufile

#普通命令提示符，在控制台下可以正常显示，如需使用取消注释，并把底部有关提示符的语句注释掉，关于如何配置命令提示符，可以看我的文章：
#《配置你的 zsh 命令提示符》：http://plafer.tk/2011/04/custom_zsh_prompt/
PROMPT='%B>%(0?.. %{[31m%}%?) %{[1;34m%}%~ %{[m%}%(!.#.$) %b'
