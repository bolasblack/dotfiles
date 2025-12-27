{
  inputs = {
    # Package sets
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-25.11-darwin";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-stable.url = "github:nixos/nixpkgs/nixos-25.11";

    flake-utils.url = "github:numtide/flake-utils";

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    brew-api = {
      url = "github:BatteredBunny/brew-api";
      flake = false;
    };

    # Environment/system management
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    c4overlay = {
      url = "github:bolasblack/nix-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, darwin, home-manager, flake-utils, ... }@inputs:
    let
      nixVersion = "25.11";

      overlays = {
        c4overlay = inputs.c4overlay.overlay;

        brewCasks = final: prev: {
          brewCasks = import ./brew-casks.nix rec {
            pkgs = nixpkgs.legacyPackages.${final.system};
            brew-api = inputs.brew-api;
            lib = pkgs.lib;
            stdenv = pkgs.stdenv;
          };
        };
      };

      nixConfig = {
        registry = {
          nixpkgs.flake = nixpkgs;
        };
      };

      nixpkgsConfig = with inputs; {
        config = { allowUnfree = true; };
        overlays = builtins.attrValues overlays;
      };

      pkgs = system: import nixpkgs {
        inherit system;
        inherit (nixpkgsConfig) config overlays;
      };

      homeManagerCommonImports = [
        ./home.nix
      ];

      homeManagerDarwinImports = [
        ./darwin-home.nix
      ];

      mkDarwinConfig = { system, username }:
        darwin.lib.darwinSystem {
          inherit system;
          modules = [
            {
              nix = nixConfig // {
                package = inputs.nixpkgs-unstable.legacyPackages.${system}.nix;
              };
              nixpkgs = nixpkgsConfig;
              users.users.${username}.home = "/Users/${username}";
            }
            ./nix-darwin.nix
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.users.${username} = {
                imports =
                  homeManagerCommonImports ++
                  homeManagerDarwinImports;
              };
            }
          ];
        };

    mkHomeConfig = { system, username, homeDirectory, extraImports ? [] }:
      home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs system;
        modules = [{
          nix = nixConfig // {
            package = inputs.nixpkgs-unstable.legacyPackages.${system}.nix;
          };

          nixpkgs = nixpkgsConfig;

          imports =
            homeManagerCommonImports ++
            extraImports;

          home = {
            inherit username;
            inherit homeDirectory;
            stateVersion = nixVersion;
          };
        }];
      };

    in
    {
      homeConfigurations = {
        linux = mkHomeConfig rec {
          system = builtins.currentSystem;
          username = "c4605";
          homeDirectory = "/home/${username}";
        };

        darwin = mkHomeConfig rec {
          system = "aarch64-darwin";
          username = "c4605";
          homeDirectory = "/Users/${username}";
          extraImports = homeManagerDarwinImports;
        };
      };
      darwinConfigurations = {
        darwin = mkDarwinConfig {
          system = "aarch64-darwin";
          username = "c4605";
        };
      };
    } // flake-utils.lib.eachDefaultSystem (system: {
      legacyPackages = import nixpkgs {
        inherit system;
        inherit (nixpkgsConfig) config overlays;
      };
    });
}
