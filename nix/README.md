# nix

1. Link file

    ```bash
    mkdir -p ~/.config/nixpkgs && cd ~/.config/nixpkgs
    ln -s ../../dotfiles/nix/home.nix
    ```

1. Install nix at first (https://nixos.org/nix/manual/#ch-installing-binary)

    ```bash
    sh <(curl https://nixos.org/nix/install)
    ```

1. Install home-mamanger

    ```bash
    nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
    nix-channel --update

    nix-shell '<home-manager>' -A install

    echo '. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"' >> ~/.profile
    ```
