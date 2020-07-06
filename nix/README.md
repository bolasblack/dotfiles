# Nix

1. (Optional) add tsinghua nix mirror

    ```bash
    vim ~/.config/nix/nix.conf
    # modify to
    # substituters = https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store https://cache.nixos.org
    ```

1. Link file

    ```bash
    mkdir -p ~/.config/nixpkgs
    cd ~/.config/nixpkgs && ln -s ../../dotfiles/nix/home.nix
    ```

1. Install nix at first (https://nixos.org/nix/manual/#ch-installing-binary)

    ```bash
    sh <(curl https://nixos.org/nix/install)
    ```

1. Install c4605's nix overlay

   ```bash
   git clone https://github.com/bolasblack/nix-overlay.git c4605-nix-overlay
   cd c4605-nix-overlay && ./install.sh
   ```

1. Install home-mamanger

    ```bash
    nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
    nix-channel --update

    nix-shell '<home-manager>' -A install
    ```
