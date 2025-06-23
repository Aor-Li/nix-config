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
    
    hosts = [ "wsl-nixos" "wsl-nixos-hw" "aoostar"];
    users = [ "aor" ];
  in {
    nixosConfigurations = lib.genAttrs hosts (hostname: 
      nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs nixpkgs;
        };
        system = "x86_64-linux";
        modules = [ ./hosts/${hostname} ];
      });

    homeConfigurations = lib.genAttrs users (username:
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./users/${username}.nix ];
      });
  };
}

