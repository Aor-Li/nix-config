{ inputs, pkgs, ... }:
{
  imports = [
    inputs.lazyvim.homeModules.default
  ];
  nvim.enable = true;
}
