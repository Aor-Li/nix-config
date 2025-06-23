{ pkgs, inputs, systemConfig, ... }:
{
  imports = [
    ./core.nix
    ./system.nix
  ];
}