{ pkgs, inputs, hostConfig, ... }:
{
  imports = [
    ./vpn.nix
  ];

  networking = {
    networkmanager.enable = true;
    hostName = hostConfig.host_name;
    
    # Enable firewall with specific rules
    firewall = {
      enable = true;
      # Allow SSH and RDP connections
      allowedTCPPorts = [ 22 3389 ];
      allowedUDPPorts = [ 3389 ];
      
      # Allow local network access (adjust subnet as needed)
      # trustedInterfaces = [ "enp*" "wlp*" ];
      
      # Allow ping
      allowPing = true;
    };
  };
}
