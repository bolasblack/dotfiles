{
  inputs = {
    # Package sets
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    nixpkgs-stable-darwin.url = "github:nixos/nixpkgs/nixpkgs-20.09-darwin";
    nixos-stable.url = "github:nixos/nixpkgs/nixos-20.09";

    # Environment/system management
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";
    flake-compat.url = "github:edolstra/flake-compat";
    flake-compat.flake = false;
    neovim.url = "github:neovim/neovim/4be0e92db01a502863ac4bb26dd0fee16d833145?dir=contrib";
    neovim.inputs.nixpkgs.follows = "nixpkgs";

    c4overlay.url = "github:bolasblack/nix-overlay";
    c4overlay.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, darwin, home-manager, flake-utils, c4overlay, ... }@inputs:
  let
    nixpkgsConfig = with inputs; {
      config = { allowUnfree = true; };
      overlays = self.overlays;
    };

    homeManagerCommonConfig = {
      imports = [
        ./home.nix
      ];
    };
  in {
    overlays = [
      c4overlay.overlay
      (final: prev: {
        neovim-nightly = inputs.neovim.packages.${prev.stdenv.system}.neovim;
      })
    ];

    homeConfigurations = {
      bootstrap = home-manager.lib.homeManagerConfiguration rec {
        system = "x86_64-linux";
        username = "c4605";
        homeDirectory = "/home/${username}";
        configuration = {
          imports = [ homeManagerCommonConfig ];
          nixpkgs = nixpkgsConfig;
        };
      };

      darwin = home-manager.lib.homeManagerConfiguration rec {
        system = "x86_64-darwin";
        username = "c4605";
        homeDirectory = "/Users/${username}";
        configuration = {
          imports = [ homeManagerCommonConfig ];
          nixpkgs = nixpkgsConfig;
        };
      };
    };
  } // flake-utils.lib.eachDefaultSystem (system: {
      legacyPackages = import nixpkgs { inherit system; inherit (nixpkgsConfig) config overlays; };
  });
}
