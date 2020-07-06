{ pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    zsh
    tmux
    # emacs
    emacsUnstable-nox
    vim
    git
    git-lfs
  ];

  home.packages = with pkgs; [
    # 系统级的工具
    coreutils
    findutils
    diffutils
    moreutils
    gnugrep
    gnused
    gawk
    gnutar
    less
    gnupg
    curl
    wget
    which
    tree
    gzip
    unzip

    # nix 工具
    nix-bundle # https://github.com/matthewbauer/nix-bundle
    nix-index  # https://github.com/bennofs/nix-index
    cachix

    # 编程语言
    ant
    cargo
    rustc
    ruby
    clojure

    # 其他
    fd
    bat
    ripgrep
    fzf
    direnv
    jq
    htop
    aria2
    ffmpeg-full
    cloc
    entr
    # eternal-terminal
    iperf
    awscli
    ledger
    wireguard-tools
    watchman
    pre-commit
  ];

  home.file = {
    ".tmux.conf".text = ''source-file ~/dotfiles/tmuxfiles/tmux.conf'';
    ".emacs".text = ''(load "~/.emacsrc/init.el")'';
  };

  home.stateVersion = "20.03";

  home.activation.cloneEmacsrc = ''
if [ ! -d "$HOME/.emacsrc" ]; then
  (cd "$HOME" && git clone --depth=1 git@github.com:bolasblack/.emacsrc.git)
fi
  '';

  home.activation.cloneVimrc = ''
if [ ! -d "$HOME/.vim" ]; then
  curl -L https://raw.github.com/bolasblack/.vim/master/scripts/bootstrap.sh | bash
fi
  '';

  programs.home-manager = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
[ -e "$HOME/.zshrc.custom" ] && source $HOME/.zshrc.custom
    '';
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    defaultCommand = "fd --type file --color=always";
    defaultOptions = ["--ansi"];
  };
}
