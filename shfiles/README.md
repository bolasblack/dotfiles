# shfiles

## shell

macOS 推荐使用 GNU 套件替代 BSD 的

* `brew install coreutils findutils diffutils gnu-sed gnu-tar gnu-which grep gzip --with-default-names`
* `nix-env -iA nixpkgs.coreutils nixpkgs.findutils nixpkgs.diffutils nixpkgs.gnused nixpkgs.gnutar nixpkgs.which nixpkgs.gnugrep nixpkgs.gzip`

https://www.topbug.net/blog/2013/04/14/install-and-use-gnu-command-line-tools-in-mac-os-x/

## Zsh

```sh
(cd ~ && echo '\nexport SHF_ROOT=~/dotfiles/shfiles/\nsource $SHF_ROOT/zshrc' >> ~/.zshrc)
```

如果要使用 zsh 的 git-flow 插件，请不要安装 `git-completion.zsh` 或者 `git-completion.bash` 。

具体参考：https://github.com/robbyrussell/oh-my-zsh/issues/1717#issuecomment-22540099

## Bash

```sh
(cd ~ && echo '\nexport SHF_ROOT=~/dotfiles/shfiles/\nsource $SHF_ROOT/rc' >> ~/.bashrc)
```
