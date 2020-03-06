{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.03";

  home.packages = [
    # 系统级的工具
    pkgs.coreutils
    pkgs.findutils
    pkgs.diffutils
    pkgs.moreutils
    pkgs.gnugrep
    pkgs.gnused
    pkgs.gawk
    pkgs.gnutar
    pkgs.less
    pkgs.gnupg
    pkgs.curl
    pkgs.wget
    pkgs.which
    pkgs.tree
    pkgs.gzip
    pkgs.unzip

    # nix 工具
    pkgs.nix-bundle

    # 编程语言
    pkgs.ant
    pkgs.cargo
    pkgs.rustc
    pkgs.ruby
    pkgs.clojure

    # 完全离不开
    pkgs.zsh
    pkgs.tmux
    pkgs.emacs
    pkgs.vim
    pkgs.git
    pkgs.git-lfs
    pkgs.fd
    pkgs.bat
    pkgs.ripgrep
    pkgs.fzf
    pkgs.direnv

    # 其他
    pkgs.jq
    pkgs.htop
    pkgs.aria2
    pkgs.ffmpeg
    pkgs.cloc
    pkgs.entr
    pkgs.eternal-terminal
    pkgs.iperf
    pkgs.awscli
    pkgs.ledger
    pkgs.wireguard-tools
  ];
}
