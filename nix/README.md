# Nix

1. Install nix, follow the document: https://nixos.org/manual/nix/unstable/installation/installing-binary.html

   ```bash
   sh <(curl -L https://nixos.org/nix/install) --daemon
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
   cd ~
   git clone git@github.com:bolasblack/dotfiles.git
   nix run github:nix-community/home-manager/master -- switch \
     --flake "$HOME/dotfiles/nix#darwin"
   ```

1. Bonus, some useful shell functions

   ```bash
   nix-switch() {
     nix run github:nix-community/home-manager/master -- switch \
       --flake "$HOME/dotfiles/nix#darwin" \
       $@
   }
   nix-switch-build() {
     nix run github:nix-community/home-manager/master -- build \
       --flake "$HOME/dotfiles/nix#darwin" \
       $@
   }

   cachix-push() {
     cd "$HOME/dotfiles"
     nix flake archive --json \
       | jq -r '.path,(.inputs|to_entries[].value.path)' \
       | cachix push bolasblack
   }

   nix-optimize-store() {
    # clean up all history versions older than 7 days
    nix profile wipe-history --older-than 7d --profile /nix/var/nix/profiles/system

    # clean up command won't delete data, need to run gc command to delete all unused packages
    nix-collect-garbage --delete-old

    # optimize nix store
    nix-store --optimise
   }
   ```

## Resources

- [Nix(package manager)](https://nixos.org/manual/nix/stable/): official manual
- [Nixpkgs(Packages collection)](https://nixos.org/manual/nixpkgs/stable/): official manual
- [Home Manager](https://nix-community.github.io/home-manager/): official manual
- [NixOS & Flakes Book](https://nixos-and-flakes.thiscute.world/): An unofficial book for beginners
- [noogle](https://noogle.dev/): Search all nix built-in functions
- [MyNixOS](https://mynixos.com/): Search all options of `nixpkgs`, `nixosConfigurations` and [`homeConfigurations`](https://mynixos.com/options/home)
- [Home Manager Option Search](https://home-manager-options.extranix.com/): Search all options of `homeConfigurations`
- [Flakes - NixOS Wiki](https://nixos.wiki/wiki/Flakes)
- Blog post [Nix Flakes](https://www.tweag.io/blog/2020-05-25-flakes/) by Eelco Dolstra
- Blog post [Nix 和 NixOS：你们安利方法错了](https://nyk.ma/posts/nix-and-nixos/)

## Thanks

- [malob/nixpkgs](https://github.com/malob/nixpkgs)
- [Luca's nix configuration](https://www.lucacambiaghi.com/nixpkgs/readme.html)
- [okkdev/dotnix](https://github.com/okkdev/dotnix)
