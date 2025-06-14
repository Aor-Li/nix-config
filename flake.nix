{
  description = "Aor's nixos flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # wsl
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
    # # hyperland
    # hyprland.url = "github:hyprwm/Hyprland";
    # hyprland.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, nixos-wsl, ... }@inputs: let    
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      wsl = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs nixpkgs;
          curUser = "aor";
        };
        inherit system;
        modules = [ ./machines/wsl.nix ];
      };
    };
    nixosConfigurations = {
      aoostar = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs nixpkgs;
          curUser = "aor";
        };
        inherit system;
        modules = [ ./machines/aoostar.nix ];
      };
    };

    homeManagerConfigurations = {
      aor = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./users/aor.nix ];
      };
    };
  };
}

