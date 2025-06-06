{
  description = "Aor's nixos flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # wsl
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixos-wsl, ... }@inputs: let
    mkSystem = import ./lib/mksystem.nix {
      inherit nixpkgs inputs;
    };
  in {
    nixosConfigurations.wsl = mkSystem "wsl_config" {
      os = "nixos";
      machine = "wsl";
      user = "aor";
    };
    nixosConfigurations.aoostar = mkSystem "minipc_config" {
      os = "nixos";
      machine = "aoostar";
      user = "aor";
    };
  };
}

