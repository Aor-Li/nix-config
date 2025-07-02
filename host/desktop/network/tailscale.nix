{
  config,
  pkgs,
  ...
}:
let
  tailscale_port = 41641;
in
{
  # enable tailscale
  environment.systemPackages = [ pkgs.tailscale ];
  services.tailscale = {
    enable = true;
    port = tailscale_port;

    # allow the Tailscale UDP port through the firewall
    openFirewall = true;
    useRoutingFeatures = "client";
    extraUpFlags = "--accept-routes";
  };

  # add to the firewall allowed ports
  networking.firewall.allowedUDPPorts = [ tailscale_port ];
}
