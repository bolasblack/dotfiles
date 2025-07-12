{
  inputs = {
    # Package sets
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-25.05-darwin";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    # Environment/system management
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    c4overlay = {
      url = "github:bolasblack/nix-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # brew-nix = {
    #   url = "github:BatteredBunny/brew-nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   inputs.flake-utils.follows = "flake-utils";
    #   inputs.nix-darwin.follows = "darwin";
    #   inputs.brew-api.follows = "brew-api";
    # };
    brew-api = {
      url = "github:BatteredBunny/brew-api";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, darwin, home-manager, flake-utils, ... }@inputs:
    let
      nixConfig = {
        registry = {
          nixpkgs.flake = nixpkgs;
        };
      };

      nixpkgsConfig = with inputs; {
        config = { allowUnfree = true; };
        overlays = self.overlays;
      };

      username = "c4605";

      pkgs = system: nixpkgs.legacyPackages.${system};

      homeManagerCommonImports = [
        ./home.nix
      ];

      homeManagerDarwinImports = [
        ./darwin-home.nix
      ];

      homeManagerCommonModules = [{
        nix = nixConfig;
        nixpkgs = nixpkgsConfig;
        imports = homeManagerCommonImports;
      }];
    in
    {
      overlays = [
        inputs.c4overlay.overlay

        # inputs.brew-nix.overlays.default
        (final: prev:
          let
            pkgs = nixpkgs.legacyPackages.${final.system};
          in
          {
            brewCasks = import ./brew-casks.nix {
              inherit pkgs;
              brew-api = inputs.brew-api;
              lib = pkgs.lib;
              stdenv = pkgs.stdenv;
            };
          }
        )

        # (final: prev: {
        #   neovim-nightly = inputs.neovim.packages.${prev.stdenv.system}.neovim;
        # })
      ];

      homeConfigurations = {
        linux = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs builtins.currentSystem;
          modules = homeManagerCommonModules ++ [{
            home = {
              inherit username;
              homeDirectory = "/home/${username}";
              stateVersion = "25.05";
            };
          }];
        };

        darwin = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs builtins.currentSystem;
          modules =
            homeManagerCommonModules ++
            [{
              nix.package = inputs.nixpkgs-unstable.legacyPackages.${builtins.currentSystem}.nix;
              imports = homeManagerDarwinImports;
              home = {
                inherit username;
                homeDirectory = "/Users/${username}";
                stateVersion = "25.05";
              };
            }];
        };
      };

      darwinConfigurations = {
        darwin = darwin.lib.darwinSystem {
          system = builtins.currentSystem;
          modules = [
            {
              nix = nixConfig // {
                package = inputs.nixpkgs-unstable.legacyPackages.${builtins.currentSystem}.nix;
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
      };
    } // flake-utils.lib.eachDefaultSystem (system: {
      legacyPackages = import nixpkgs {
        inherit system;
        inherit (nixpkgsConfig) config overlays;
      };
    });
}
