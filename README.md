# My Dotfiles

## Zsh

```sh
brew install zplug
(cd ~ && echo 'source ~/dotfiles/zshfiles/zshrc' >> ~/.zshrc)
```

**Mac 用户推荐安装 `coreutils` 使用 GNU 的命令替代自带的 `ls` 等命令**

如果要使用 zsh 的 git-flow 插件，请不要安装 `git-completion.zsh` 或者 `git-
completion.bash` 。

具体参考：https://github.com/robbyrussell/oh-my-zsh/issues/1717#issuecomment-22540099

## Tmux

```bash
(cd ~ && echo 'source-file ~/dotfiles/tmuxfiles/tmux.conf' >> ~/.tmux.conf)
```

**Mac 用户请先安装 `reattach-to-user-namespace`**

推荐安装 tmuxinator : http://zuyunfei.com/2013/08/09/tmuxinator-best-mate-of-tmux/

顺便可以安装一个增加了 Powerline 特殊字符的字体：

* [Monaco for Powerline](https://gist.github.com/baopham/1838072)
* [Powerline fonts](https://github.com/Lokaltog/powerline-fonts)

## [Karabiner-Elements](https://github.com/tekezo/Karabiner-Elements) (OS X)

```bash
mkdir -p ~/.config/karabiner/ && \
cd ~/.config/karabiner/ && \
ln -s ~/dotfiles/Karabiner-Elements/karabiner.json
```

只实现 tab+hjkl 变成方向键：

```bash
open "karabiner://karabiner/assets/complex_modifications/import?url=$(python -c "import urllib; print urllib.quote(u'file://$HOME/dotfiles/Karabiner-Elements/tab_rule.json', safe='~()*\!.\'')")"
```

## [Rime](http://rime.im/)

```bash
cd ~/Library/Rime && \
ln -s ~/dotfiles/Rime/default.custom.yaml && \
ln -s ~/dotfiles/Rime/squirrel.custom.yaml
```
