{
  description = "Aor's nixos flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-wsl, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        nixos-wsl.nixosModules.default {
          system.stateVersion = "24.11";
          wsl.enable = true;
          wsl.defaultUser = "aor";
        }
        ./nixos/configuration.nix
      ];
    };
	
    # system.stateVersion = "24.11";
    
    #nix.settings.substituers = [
    #  "https://mirror.sjtu.edu.cn/nix-channels/store"
    #  "https://mirrors.ustc.edu.cn/nix-channels/store"
    #  "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
    #];

    #nix.settings.experimental-features = [ "nix-command" "flakes" ];
    #environment = {
    #  systemPackages = with nixpkgs; [
    #    git
    #    vim
    #    wget
    #  ];
    #  variables.EDITOR = "vim";
    #};
  };
}

