{
  pkgs,
  mylib,
  lib,
  hostConfig,
  ...
}:
{
  imports = mylib.scanPaths ./.;

  config = lib.mkIf (hostConfig.machine_type == "desktop") {
    # Enable XRDP service for Windows Remote Desktop connections
    services.xrdp = {
      enable = true;
      defaultWindowManager = "startplasma-x11";
      openFirewall = true;
    };

    # Ensure Xvnc is available for XRDP
    services.xserver.enable = true;

    # Allow remote desktop connections through firewall
    networking.firewall = {
      allowedTCPPorts = [ 3389 ]; # RDP port
      allowedUDPPorts = [ 3389 ];
    };

    # Install remote desktop related packages
    environment.systemPackages = with pkgs; [
      waypipe
      xrdp
      tigervnc  # For VNC support
      remmina   # Remote desktop client
    ];

    # Configure systemd service to ensure proper startup
    systemd.services.xrdp = {
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" "systemd-tmpfiles-setup.service" ];
      wants = [ "systemd-tmpfiles-setup.service" ];
    };

    # Also ensure sesman service starts properly
    systemd.services.xrdp-sesman = {
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" "systemd-tmpfiles-setup.service" ];
    };
  };
}
