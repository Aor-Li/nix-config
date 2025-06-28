{ pkgs, lib, systemConfig, ... }:
{
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
  boot.loader = lib.mkIf (systemConfig.machine_type == "desktop" || systemConfig.machine_type == "server") {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # networking
  networking = lib.mkIf (systemConfig.machine_type == "desktop" || systemConfig.machine_type == "server") {
    hostName = systemConfig.hostname;
    networkmanager.enable = true;
    firewall.enable = true;
  };

  # users
  users = lib.mkIf (systemConfig.machine_type == "desktop" || systemConfig.machine_type == "server") {
    users = lib.listToAttrs (map (user: {
      name = user;
      value = {
        isNormalUser = true;
        description = "${user}";
        extraGroups = [ "networkmanager" "wheel" ];
      };
    }) systemConfig.users);
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
  services.displayManager.autoLogin.user = builtins.elemAt systemConfig.users 0;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # openSSH
  services.openssh.enable = true;

  # disable sleep on server
  systemd.sleep.extraConfig = lib.mkIf (systemConfig.machine_type == "server") ''
    [Sleep]
    AllowSuspend=no
    AllowHibernate=no
    AllowHybridSleep=no
    AllowSuspendThenHibernate=no
  '';
}