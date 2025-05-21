# This function creates a nixos system based on the specific host
# refer to mitchellh's flake: https://github.com/mitchellh/nixos-config/blob/main/lib/mksystem.nix
# But I do not use darwin or home-manager, and currently no overlays

{ nixpkgs, inputs, ... }: 

name : {
  os,
  machine,
  user,
}:

let 
  system = "x86_64-linux";
  systemConfig = ../systems/${os}.nix;
  machineConfig = ../machines/${machine}.nix;
  userConfig = ../users/${user}.nix;

in nixpkgs.lib.nixosSystem rec {
  inherit system;
  specialArgs = {
    inherit inputs;
    curSystem = system;
    curOS = os;
    curMachine = machine;
    curUser = user;
  };
  modules = [
    # configurations related to system (now only nixos)
    systemConfig
    # configurations related to machine (now only wsl, nixos soon)
    machineConfig
    # configurations related to user (aor)
    userConfig
    # here we expose arguments to modules
  
    # {
    #   config._module.args = {
    #     curSystem = system;
    #     curOS = os;
    #     curMachine = machine;
    #     curUser = user;
    #     inputs = inputs;
    #   };
    # }
  ];
  
}