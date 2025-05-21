{ pkgs, inputs, curUser, ... }: 

{
  inputs.nixos-wsl.nixosModules.wsl = {
    enable = true;
    defaultUser = curUser;
    startMenuLaunchers = true;
  };
}