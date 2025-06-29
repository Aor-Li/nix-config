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

  # default desktop environment
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "aor";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # openSSH
  services.openssh.enable = true;
}
