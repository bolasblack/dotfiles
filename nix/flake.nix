{
  inputs = {
    nixpkgs-darwin-stable.url = "github:nixos/nixpkgs/nixpkgs-25.11-darwin";
    nixpkgs-linux-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    home-manager-darwin = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs-darwin-stable";
    };
    home-manager-linux = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs-linux-stable";
    };

    c4overlay.url = "github:bolasblack/nix-overlay";
  };

  outputs = { self, flake-utils, ... }@inputs: let
    overlays = {
      c4overlay = inputs.c4overlay.overlay;
    };

    nixpkgsConfig = {
      config = { allowUnfree = true; };
      overlays = builtins.attrValues overlays;
    };

    homeManagerCommonImports = [
      ./home.nix
    ];

    mkHomeConfig = {
      home-manager,
      nixpkgs,
      system,
      username,
      homeDirectory,
      extraImports ? []
    }:
      home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          inherit (nixpkgsConfig) config overlays;
        };

        modules = [{
          imports =
            homeManagerCommonImports ++
            extraImports;

          home = {
            inherit username;
            inherit homeDirectory;
            stateVersion = "25.11";
          };
        }];
      };

    in
    {
      homeConfigurations = {
        linux = mkHomeConfig rec {
          home-manager = inputs.home-manager-linux;
          nixpkgs = inputs.nixpkgs-linux-stable;
          system = builtins.currentSystem;
          username = "c4605";
          homeDirectory = "/home/${username}";
        };

        darwin = mkHomeConfig rec {
          home-manager = inputs.home-manager-darwin;
          nixpkgs = inputs.nixpkgs-darwin-stable;
          system = "aarch64-darwin";
          username = "c4605";
          homeDirectory = "/Users/${username}";
        };
      };
    };
}
