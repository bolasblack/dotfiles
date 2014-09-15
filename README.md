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

## [Mjolnir](https://github.com/sdegutis/mjolnir) (OS X)

```bash
(cd ~ && ln -s dotfiles/mjolnir .mjolnir)
```

一个窗口管理工具，支持使用 lua 扩展，里面的 Alfred Workflow 暂时已经失效了。

## [Karabiner](https://pqrs.org/osx/karabiner/) (OS X)

```bash
(cd ~ && \
mv ~/Library/Application\ Support/Karabiner/private.xml{,.bk} && \
cp ~/dotfiles/karabiner/private.xml ~/Library/Application\ Support/Karabiner/private.xml && \
ln -s dotfiles/karabiner .karabiner)
```

一个非常优秀的键映射工具，几乎能满足任何相关需求。
