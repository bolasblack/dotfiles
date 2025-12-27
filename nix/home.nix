{ config, pkgs, stdenv, lib, ... }:

let

  vimWithLuaSupport = lib.overrideDerivation pkgs.vim-full (o: {
    gui = false;
    luaSupport = true;
  });

in
{
  # Packages with configuration --------------------------------------------------------------- {{{
  programs.home-manager = {
    enable = true;
  };

  # Bat, a substitute for cat.
  # https://github.com/sharkdp/bat
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.bat.enable
  programs.bat = {
    enable = true;
    config = {
      style = "plain";
    };
  };

  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.htop.enable
  programs.htop = {
    enable = true;
    settings.show_program_path = true;
  };

  # https://rycee.gitlab.io/home-manager/options.xhtml#opt-programs.fzf.enable
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    defaultCommand = "fd --type file --color=always";
    defaultOptions = [ "--ansi" ];
  };

  # https://rycee.gitlab.io/home-manager/options.xhtml#opt-services.tmux.enable
  programs.tmux = {
    enable = true;
    extraConfig = ''
      source-file ~/dotfiles/tmuxfiles/tmux.conf
    '';
  };

  # https://rycee.gitlab.io/home-manager/options.xhtml#opt-services.neovim.enable
  programs.neovim = {
    enable = true;
    extraConfig = ''
      if filereadable($HOME . "/.vim/vimrc")
        source $HOME/.vim/vimrc
      endif
    '';
  };

  # https://rycee.gitlab.io/home-manager/options.xhtml#opt-services.emacs.enable
  programs.emacs = {
    enable = true;
    extraConfig = ''
      (load "~/.emacsrc/init.el")
    '';
  };

  # https://direnv.net
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.direnv.enable
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;

    mise.enable = true;

    nix-direnv.enable = true;

    # https://direnv.net/man/direnv.toml.1.html
    config = {
      load_dotenv = true;
    };

    stdlib = ''
    '';
  };

  # https://mise.jdx.dev/
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.mise.enable
  programs.mise = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;

    settings = {
      experimental = true;
    };

    globalConfig = {
      tools = {
        pipx = "latest";
        "pipx:uv" = "latest";
      };
    };
  };

  # https://github.com/nix-community/home-manager/blob/bf893ad4cbf46610dd1b620c974f824e266cd1df/modules/programs/bash.nix
  programs.bash = {
    enable = true;
    enableCompletion = true;

    profileExtra = ''
      export CC=/usr/bin/clang
      export CXX=/usr/bin/clang++

      [ -e "$HOME/.profile.custom" ] && source "$HOME/.profile.custom"
    '';
  };

  # https://github.com/nix-community/home-manager/blob/bf893ad4cbf46610dd1b620c974f824e266cd1df/modules/programs/zsh/default.nix
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    # https://rycee.gitlab.io/home-manager/options.xhtml#opt-programs.zsh.initContent
    initContent = lib.mkMerge [
      # make sure this config is on the bottom of configs to make sure the custom config is loaded last
      (lib.mkOrder 2000 ''
        export CC=/usr/bin/clang
        export CXX=/usr/bin/clang++

        [ -e "$HOME/.zshrc.custom" ] && source "$HOME/.zshrc.custom"
      '')
    ];
  };
  # }}}

  # Other packages ----------------------------------------------------------------------------- {{{
  home.packages = (with pkgs; [
    # nix 工具
    nix-prefetch # https://github.com/msteen/nix-prefetch
    nix-inspect
    nix-bundle # https://github.com/matthewbauer/nix-bundle
    nix-index # https://github.com/bennofs/nix-index
    nixpkgs-fmt
    # nix-du
    cachix
    comma

    # 系统工具
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
    vimWithLuaSupport
    rsync

    # 开发工具
    git
    git-lfs
    subversion
    mercurial
    gcc

    # Rust
    # cargo
    cargo-binstall
    libiconv # needed by cargo
    rustup
    evcxr

    # 其他
    #jupyter
    mosh
    age
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
    pre-commit
    git-subrepo
    git-secret
    editorconfig-core-c
    syncthing
    babashka
    netcat-gnu
    sshuttle
    rclone-c4
    graphviz

    fn-cli-c4
    yt-dlp
    #awscli
    #azure-cli

    maple-mono.Normal-NF-CN

    # Python
    (python310.withPackages (ps: with ps; [
    ]))
  ]);
  # }}}

  # https://github.com/nix-community/home-manager/blob/bf893ad4cbf46610dd1b620c974f824e266cd1df/modules/home-environment.nix

  home.shell.enableShellIntegration = true;

  home.sessionPath =
    [] ++
    lib.optionals pkgs.stdenv.isDarwin [
      "/opt/homebrew/bin/"
      "/opt/homebrew/opt/trash/bin"
    ];

  home.sessionVariables = {
    LIBRARY_PATH = "$LIBRARY_PATH:$HOME/.nix-profile/lib/";
    PYTHONPATH = "$HOME/.nix-profile/lib/python3.10/site-packages/:$PYTHONPATH";
  };

  home.file.home-manager-config = {
    enable = true;
    recursive = false;
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nix";
    target = ".config/home-manager";
  };

  # home.activation.exampleProfile = lib.hm.dag.entryAfter ["writeBoundary"] (
  #   ''
  #   ''
  # );
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
