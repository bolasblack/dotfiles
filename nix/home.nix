{ pkgs, lib, ... }:

let

  vimWithLuaSupport = lib.overrideDerivation pkgs.vim_configurable (o: {
    gui = false;
    luaSupport = true;
  });

in {
  # Packages with configuration --------------------------------------------------------------- {{{
  programs.home-manager = {
    enable = true;
  };

  # Bat, a substitute for cat.
  # https://github.com/sharkdp/bat
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.bat.enable
  programs.bat = {
    enable = true;
    config = { style = "plain"; };
  };

  # https://direnv.net
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.direnv.enable
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config = {
      load_dotenv = true;
    };
  };

  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.htop.enable
  programs.htop = {
    enable = true;
    settings.show_program_path = true;
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

  programs.neovim = {
    enable = true;
    extraConfig = ''
if filereadable($HOME . "/.vim/vimrc")
  source $HOME/.vim/vimrc
endif
    '';
  };
  # }}}

  # Other packages ----------------------------------------------------------------------------- {{{
  home.packages = with pkgs; [
    tmux
    emacs
    vimWithLuaSupport
    git
    git-lfs
    subversion
    mercurial

    # 系统级的工具
    coreutils
    findutils
    diffutils
    moreutils
    gnumake
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
    nix-prefetch # https://github.com/msteen/nix-prefetch
    nix-bundle # https://github.com/matthewbauer/nix-bundle
    nix-index  # https://github.com/bennofs/nix-index
    cachix

    # 编程语言
    gcc
    ant
    cargo
    cargo-binstall
    libiconv # needed by cargo
    rustc
    ruby
    clojure
    asdf-vm

    # 其他
    fd
    ripgrep
    jq
    aria2
    ffmpeg
    cloc
    entr
    #eternal-terminal
    iperf
    ledger
    wireguard-tools
    watchman
    pre-commit
    gitAndTools.git-subrepo
    gitAndTools.git-secret
    editorconfig-core-c
    syncthing
    babashka
    netcat-gnu
    sshuttle
    rclone

    fn-cli-c4
    #awscli
    #azure-cli
  ];
  # }}}

  home.sessionVariables = {
    LIBRARY_PATH = "$LIBRARY_PATH:$HOME/.nix-profile/lib/";
  };

  home.file = {
    ".tmux.conf".text = ''source-file ~/dotfiles/tmuxfiles/tmux.conf'';
    ".emacs".text = ''(load "~/.emacsrc/init.el")'';
  };

  home.activation.cloneEmacsrc = ''
if [ ! -d "$HOME/.emacsrc" ]; then
  (cd "$HOME" && git clone --depth=1 git@github.com:bolasblack/.emacsrc.git)
fi
  '';

  home.activation.cloneVimrc = ''
#if [ ! -d "$HOME/.vim" ]; then
#  curl -L https://raw.github.com/bolasblack/.vim/master/scripts/bootstrap.sh | bash
#fi
  '';
}
