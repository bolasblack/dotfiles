# My Dotfiles

## Tmux

```bash
(cd ~/dotfiles && git submodule update --init && cd ~ && ln -s dotfiles/.tmux.conf)
```

**请在使用 tmux 前先在 shell 的 rc 文件后面添加一句 `source ~/dotfiles/.tmux.sh`**

**Mac 用户使用前需要先 `brew install reattach-to-user-namespace` 一下**

推荐安装 tmuxinator : http://zuyunfei.com/2013/08/09/tmuxinator-best-mate-of-tmux/

