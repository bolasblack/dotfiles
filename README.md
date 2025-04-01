# My Dotfiles

* [tmuxfiles](./tmuxfiles) tmux 的相关配置
* [shfiles](./shfiles) sh/bash/zsh 的相关配置
* [gitfiles](./gitfiles) git 的相关配置

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
# download language model
mkdir -p ~/Library/Rime && cd ~/Library/Rime
wget https://github.com/amzxyz/RIME-LMDG/releases/download/v2n3/amz-v2n3m1-zh-hans.gram

# create configuration file links
cd ~/Library/Rime && \
ln -s ~/dotfiles/Rime/default.custom.yaml && \
ln -s ~/dotfiles/Rime/squirrel.custom.yaml
```

## [Hammerspoon](http://www.hammerspoon.org/)

一个比较好用的自动化脚本工具

```bash
cd ~ && \
ln -s ~/dotfiles/hammerspoon .hammerspoon
```
