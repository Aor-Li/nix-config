# This is the default NixOS configuration for the base system.
# It contains common settings that apply to all machines
{ pkgs, lib, mylib, hostConfig, ... }:
{
  imports = mylib.scanPaths ./.;
  
  # system environments
  environment.systemPackages = with pkgs; [
    git
    vim
    htop
    wget
    coreutils
  ];
  environment.variables.EDITOR = "vim";

  # boot loader
  boot.loader = lib.mkIf (hostConfig.machine_type != "wsl") {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # users - define default user for now
  users = {
    users.aor = {
      isNormalUser = true;
      description = "aor";
      extraGroups = [ "wheel" "networkmanager" ];
    };
  };

  # time and locale
  time.timeZone = "Asia/Shanghai";
  services.timesyncd.servers = [ "time.cloudflare.com" ];
  i18n.defaultLocale = "en_US.UTF-8";

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

  # disable sleep on server
  systemd.sleep.extraConfig = lib.mkIf (hostConfig.machine_type == "server") ''
    [Sleep]
    AllowSuspend=no
    AllowHibernate=no
    AllowHybridSleep=no
    AllowSuspendThenHibernate=no
  '';
}