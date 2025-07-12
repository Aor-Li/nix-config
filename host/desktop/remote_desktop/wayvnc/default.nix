{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wayvnc # Wayland VNC server
    # wayland-protocols # Wayland protocols for compatibility
    # xdg-desktop-portal-wlr # Desktop portal for Wayland
  ];
}
