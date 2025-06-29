# This is the default NixOS configuration for the base system.
# It contains common settings that apply to all machines
{
  pkgs,
  lib,
  mylib,
  hostConfig,
  ...
}:
{
  # system environments
  environment.systemPackages = with pkgs; [
    git
    vim
    htop
    wget
    coreutils
    nixfmt-rfc-style
  ];
  environment.variables.EDITOR = "vim";
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
