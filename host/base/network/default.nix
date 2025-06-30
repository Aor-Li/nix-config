{ pkgs, inputs, hostConfig, ... }:
{
  imports = [
    ./vpn.nix
  ];

  networking = {
    networkmanager.enable = true;
    hostName = "${hostConfig.host_name}";
    
    firewall.enable = false;
  };
}
