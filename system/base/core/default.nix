{ pkgs, lib, config, ... }:
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
  boot.loader = lib.mkIf (config.system.machine_type == "desktop" ||
                          config.system.machine_type == "server") {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # networking for desktop/server (hostname is set in host config)
  networking = lib.mkIf (config.system.machine_type == "desktop" || 
                         config.system.machine_type == "server") {
    networkmanager.enable = true;
    firewall.enable = true;
  };

  # users - define default user for now
  users = lib.mkIf (config.system.machine_type == "desktop" || 
                    config.system.machine_type == "server") {
    users.aor = {
      isNormalUser = true;
      description = "aor";
      extraGroups = [ "networkmanager" "wheel" ];
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
  systemd.sleep.extraConfig = lib.mkIf (config.system.machine_type == "server") ''
    [Sleep]
    AllowSuspend=no
    AllowHibernate=no
    AllowHybridSleep=no
    AllowSuspendThenHibernate=no
  '';
}