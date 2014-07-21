# My Dotfiles

## Zsh

```sh
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

## [Hydra](https://github.com/sdegutis/hydra) (OS X)

```bash
(cd ~ && ln -s dotfiles/hydra .hydra)
```

一个窗口管理工具，支持使用 lua 扩展，我在里面加了一个 Alfred Workflow 来便于管理。

