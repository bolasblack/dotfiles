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

## [Karabiner](https://pqrs.org/osx/karabiner/) || [Karabiner-Elements](https://github.com/tekezo/Karabiner-Elements) (OS X)

* Karabiner

    ```bash
    mv ~/Library/Application\ Support/Karabiner/private.xml{,.bk}
    cp ~/dotfiles/karabiner/private.xml ~/Library/Application\ Support/Karabiner/private.xml
    ```

* Karabiner-Elements

    ```bash
    mkdir -p ~/.karabiner.d/ && \
    cd ~/.karabiner.d/ && \
    ln -s ~/dotfiles/Karabiner-Elements/configuration
    ```

Karabiner 是一个非常优秀的键映射工具，几乎能满足任何和键盘相关的需求，但在 macOS 10.12 后就无法正常使用了，取而代之的是 Karabiner-Elements 。

不过目前 Karabiner-Elements 还处于开发中，功能十分薄弱，部分 Karabiner 本来可以支持的功能需要使用 Hammerspoon 配合才能实现。
