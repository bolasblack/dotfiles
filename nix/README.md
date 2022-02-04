# Nix

1. Install nix 2.4, follow the document: https://nixos.org/manual/nix/unstable/installation/installing-binary.html

    ```bash
    sh <(curl -L https://nixos.org/nix/install) --daemon
    ```

1. Edit `~/.config/nix/nix.conf`

   ```conf
   # Enable flake feature
   experimental-features = nix-command flakes

   # (Optional) add tsinghua nix mirror
   # substituters = https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store https://cache.nixos.org
   ```

1. Install [home-manager](https://nix-community.github.io/home-manager/)

    ```bash
    nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
    nix-channel --add https://nixos.org/channels/nixpkgs-21.11-darwin nixpkgs
    nix-channel --update

    nix-shell '<home-manager>' -A install
    ```
    
    If encountered `NIX_PATH: unbound variable` error, try command:
    
    ```bash
    NIX_PATH=home-manager=${HOME}/.nix-defexpr/channels/home-manager:nixpkgs=${HOME}/.nix-defexpr/channels/nixpkgs nix-shell '<home-manager>' -A install
    ```

1. Edit shell profile file

    ```bash
    # add following code
    if [ -d "$HOME/.nix-profile/etc/profile.d" ]; then
      for f in "$HOME/.nix-profile/etc/profile.d/"*.sh; do
        [ -r "$f" ] && source "$f"
      done
    fi
    ```

1. Start use home-mamanger

    ```bash
    cd <path>
    git clone git@github.com:bolasblack/dotfiles.git
    home-manager switch --flake "<path>/dotfiles/nix#darwin"
    ```
    
1. Bonus, some useful shell functions

    ```bash
    nix-switch() {
      home-manager switch --flake "$HOME/dotfiles/nix#darwin" $@
    }
    nix-switch-build() {
      home-manager build --flake "$HOME/dotfiles/nix#darwin" $@
    }
    
    cachix-push() {
      cd "$HOME/dotfiles"
      nix flake archive --json \
        | jq -r '.path,(.inputs|to_entries[].value.path)' \
        | cachix push bolasblack
    }
    ```

## Resources

* [Flakes - NixOS Wiki](https://nixos.wiki/wiki/Flakes)
* Blog post [Nix Flakes](https://www.tweag.io/blog/2020-05-25-flakes/) by Eelco Dolstra
* [Nix(package manager) manual](https://nixos.org/manual/nix/stable/)
* [Nix 3 manual](https://nixos.org/manual/nix/unstable/introduction.html)
* [Nixpkgs(Packages collection) manual](https://nixos.org/manual/nixpkgs/stable/)

## Thanks

* [malob/nixpkgs](https://github.com/malob/nixpkgs)
* [Luca's nix configuration](https://www.lucacambiaghi.com/nixpkgs/readme.html)
