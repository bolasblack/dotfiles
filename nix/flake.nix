{
  inputs = {
    # Package sets
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    nixpkgs-stable-darwin.url = "github:nixos/nixpkgs/nixpkgs-21.11-darwin";
    nixos-stable.url = "github:nixos/nixpkgs/nixos-21.11";

    # Environment/system management
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";
    flake-compat.url = "github:edolstra/flake-compat";
    flake-compat.flake = false;
    neovim.url = "github:neovim/neovim/e65b724451ba5f65dfcaf8f8c16afdd508db7359?dir=contrib";
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

    username = "c4605";

    baseConfigurations = {
      configuration = {
        imports = [
          ./common.nix
        ];
        nixpkgs = nixpkgsConfig;
      };
    };

    evalWrapper = wrapper:
      baseConfigurations // (wrapper baseConfigurations);

    mkLinuxConfigurations = wrapper:
      let
        wrapped = evalWrapper wrapper;
      in
        home-manager.lib.homeManagerConfiguration wrapped;

    mkDarwinConfigurations = wrapper:
      let
        wrapped = evalWrapper wrapper;
      in
        home-manager.lib.homeManagerConfiguration(
          nixpkgs.lib.attrsets.recursiveUpdate wrapped rec {
            configuration.imports = wrapped.configuration.imports ++ [
              ./darwin.nix
            ];
          }
        );
  in {
    overlays = [
      c4overlay.overlay
      (final: prev: {
        neovim-nightly = inputs.neovim.packages.${prev.stdenv.system}.neovim;
      })
    ];

    homeConfigurations = {
      bootstrap = mkLinuxConfigurations (base: rec {
        inherit username;
        system = "x86_64-linux";
        homeDirectory = "/home/${username}";
      });

      x86darwin = mkDarwinConfigurations (base: rec {
        inherit username;
        system = "x86_64-darwin";
        homeDirectory = "/Users/${username}";
      });

      darwin = mkDarwinConfigurations (base: rec {
        inherit username;
        system = "aarch64-darwin";
        homeDirectory = "/Users/${username}";
      });
    };
  } // flake-utils.lib.eachDefaultSystem (system: {
    legacyPackages = import nixpkgs {
      inherit system;
      inherit (nixpkgsConfig) config overlays;
    };
  });
}
