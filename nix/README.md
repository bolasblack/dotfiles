# Nix

1. Install nix 2.4

    ```bash
    sh <(curl https://nixos.org/nix/install)
    nix-env -iA nixpkgs.nixUnstable
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
    nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
    nix-channel --update

    nix-shell '<home-manager>' -A install
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
    git clone --branch chore/nix-flake git@github.com:bolasblack/dotfiles.git
    home-manager switch --flake "<path>/dotfiles/nix#darwin"
    ```

## Resources

* [Flakes - NixOS Wiki](https://nixos.wiki/wiki/Flakes)
* Blog post [Nix Flakes](https://www.tweag.io/blog/2020-05-25-flakes/) by Eelco Dolstra
* [Nix(package manager) manual](https://nixos.org/manual/nix/stable/)
* [Nix 3 manual](https://nixos.org/manual/nix/unstable/introduction.html)
* [Nixpkgs(Packages collection) manual](https://nixos.org/manual/nixpkgs/stable/)

## Thanks

* [malob/nixpkgs](https://github.com/malob/nixpkgs)
