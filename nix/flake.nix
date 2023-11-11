{
  inputs = {
    # Package sets
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-23.05-darwin";
    nixos-stable.url = "github:nixos/nixpkgs/nixos-23.05";

    # Environment/system management
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    c4overlay.url = "github:bolasblack/nix-overlay";
    c4overlay.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";
    flake-compat.url = "github:edolstra/flake-compat";
    flake-compat.flake = false;
  };

  outputs = { self, nixpkgs, darwin, home-manager, flake-utils, c4overlay, ... }@inputs:
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

    homeManagerCommonModules = extraModules: [
      {
        nix = nixConfig;
        nixpkgs = nixpkgsConfig;
        imports = homeManagerCommonImports;
      }
    ] ++ extraModules;

    nixDarwinCommonModules = { user }: [
      {
        nix = nixConfig;
        nixpkgs = nixpkgsConfig;
        users.users.${user}.home = "/Users/${user}";
      }
      ./nix-darwin.nix
      home-manager.darwinModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.users.${user} = {
          imports = homeManagerCommonImports;
        };
      }
    ];
  in {
    overlays = [
      c4overlay.overlay
      (final: prev: {
        neovim-nightly = inputs.neovim.packages.${prev.stdenv.system}.neovim;
      })
    ];

    homeConfigurations = {
      linux = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs "x86_64-linux";
        modules = homeManagerCommonModules [{
          home = {
            inherit username;
            homeDirectory = "/home/${username}";
            stateVersion = "23.05";
          };
        }];
      };

      x86darwin = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs "x86_64-darwin";
        modules = homeManagerCommonModules [{
          home = {
            inherit username;
            homeDirectory = "/Users/${username}";
            stateVersion = "23.05";
          };
        }];
      };

      darwin = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs "x86_64-darwin";
        modules = homeManagerCommonModules [{
          home = {
            inherit username;
            homeDirectory = "/Users/${username}";
            stateVersion = "23.05";
          };
        }];
      };
    };

    darwinConfigurations = {
      x86darwin = darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = nixDarwinCommonModules { user = username; };
      };

      darwin = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = nixDarwinCommonModules { user = username; };
      };
    };
  } // flake-utils.lib.eachDefaultSystem (system: {
    legacyPackages = import nixpkgs {
      inherit system;
      inherit (nixpkgsConfig) config overlays;
    };
  });
}
