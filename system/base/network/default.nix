{ pkgs, inputs, ... }:
{
  imports = [
    ./vpn.nix
  ];

  networking = {
    networkmanager.enable = true;
    firewall.enable = true;
  };
}