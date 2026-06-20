{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  builtins,
  ...
}:

let

  stdenv = pkgs.stdenv;

  homePath = config.home.homeDirectory;
  dotfilePath = "${config.home.homeDirectory}/dotfiles";

  vimWithLuaSupport = pkgs.vim-full.override {
    guiSupport = false;
  };

in
{
  # Packages with configuration --------------------------------------------------------------- {{{
  imports = [
    ./modules/home/homebrew-bundle.nix
  ];

  # https://nix-community.github.io/home-manager/options/home-manager/programs/home-manager.html
  programs.home-manager = {
    enable = true;
  };

  # Bat, a substitute for cat.
  # https://github.com/sharkdp/bat
  # https://nix-community.github.io/home-manager/options/home-manager/programs/bat.html
  programs.bat = {
    enable = true;
    config = {
      style = "plain";
    };
  };

  # https://nix-community.github.io/home-manager/options/home-manager/programs/htop.html
  programs.htop = {
    enable = true;
    settings.show_program_path = true;
  };

  # https://nix-community.github.io/home-manager/options/home-manager/programs/tmux.html
  programs.tmux = {
    enable = true;
    extraConfig = ''
      bind-key s run-shell "${./files/tmux/fzf-select-session.sh}"
      bind-key w run-shell "${./files/tmux/fzf-select-window.sh}"
      source-file ${dotfilePath}/tmuxfiles/tmux.conf
    '';
  };

  # https://nix-community.github.io/home-manager/options/home-manager/programs/sesh.html
  programs.sesh = {
    enable = true;
    enableTmuxIntegration = false; # we replaced it with our own version
  };

  # https://nix-community.github.io/home-manager/options/home-manager/programs/fzf.html
  programs.fzf = {
    enable = true;

    defaultCommand = "fd --type file --color=always";
    defaultOptions = [ "--ansi" ];

    enableBashIntegration = true;
    enableZshIntegration = true;
    tmux.enableShellIntegration = true;
  };

  # https://nix-community.github.io/home-manager/options/home-manager/programs/neovim.html
  programs.neovim = {
    enable = true;
    extraConfig = ''
      if filereadable(${dotfilePath}/vim/vimrc)
        source ${dotfilePath}/vim/vimrc
      endif
    '';
  };

  # https://nix-community.github.io/home-manager/options/home-manager/programs/emacs.html
  programs.emacs = {
    enable = true;
    extraConfig = ''
      (load "${homePath}/.emacsrc/init.el")
    '';
  };

  # https://direnv.net
  # https://nix-community.github.io/home-manager/options/home-manager/programs/direnv.html
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;

    mise = {
      enable = true;
      package = pkgs.mise;
    };

    nix-direnv.enable = true;

    # https://direnv.net/man/direnv.toml.1.html
    config = {
      load_dotenv = true;
    };

    stdlib = '''';
  };

  # https://mise.jdx.dev/
  # https://nix-community.github.io/home-manager/options/home-manager/programs/mise.html
  programs.mise = {
    enable = true;
    package = pkgs.mise;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
  xdg.configFile."mise/conf.d/home-manager.toml".text = ''
    [settings]
    experimental = true
    [tools]
    pipx = "latest"
    "pipx:uv" = "latest"
  '';


  # https://nix-community.github.io/home-manager/options/home-manager/programs/bash.html
  programs.bash = {
    enable = true;
    enableCompletion = true;

    profileExtra = ''
      export CC=/usr/bin/clang
      export CXX=/usr/bin/clang++

      [ -e "$HOME/.profile.custom" ] && source "$HOME/.profile.custom"
    '';
  };

  # https://nix-community.github.io/home-manager/options/home-manager/programs/zsh.html
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    # https://nix-community.github.io/home-manager/options/home-manager/programs/zsh.html#programs-zsh-initContent
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
  home.packages = (
    with pkgs;
    [
      # nix 工具
      nix-prefetch # https://github.com/msteen/nix-prefetch
      nix-inspect
      nix-bundle # https://github.com/matthewbauer/nix-bundle
      nix-index # https://github.com/bennofs/nix-index
      nixfmt
      nixpkgs-fmt
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
      (python315.withPackages (
        ps: with ps; [
        ]
      ))
    ]
  );
  # }}}

  # https://nix-community.github.io/home-manager/options/home-manager/home.html

  home.shell.enableShellIntegration = true;

  home.homebrewBundle = {
    enable = true;

    extraBrewfile = "${dotfilePath}/nix/private/Brewfile";

    taps = [
      "homebrew/core"
      "beeftornado/rmtree"
    ];

    brews = [
      "mas"
      "beeftornado/rmtree/brew-rmtree"
    ];

    casks = [
      "wezterm"
    ];

    mas = [
      # { name = "Xcode"; id = 497799835; }
    ];
  };

  home.sessionVariables = {
    LIBRARY_PATH = "$LIBRARY_PATH:$HOME/.nix-profile/lib/";
    PYTHONPATH = "$HOME/.nix-profile/lib/python3.10/site-packages/:$PYTHONPATH";
  };

  home.file = lib.mkMerge [
    # common
    {
      home-manager-config = {
        enable = true;
        recursive = false;
        source = config.lib.file.mkOutOfStoreSymlink "${dotfilePath}/nix";
        target = ".config/home-manager";
      };
    }

    # darwin
    (lib.mkIf stdenv.isDarwin {
      rime-custom-default = {
        enable = true;
        recursive = false;
        source = config.lib.file.mkOutOfStoreSymlink "${dotfilePath}/Rime/default.custom.yaml";
        target = "Library/Rime/default.custom.yaml";
      };

      rime-custom-squirrel = {
        enable = true;
        recursive = false;
        source = config.lib.file.mkOutOfStoreSymlink "${dotfilePath}/Rime/squirrel.custom.yaml";
        target = "Library/Rime/squirrel.custom.yaml";
      };
    })
  ];

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
