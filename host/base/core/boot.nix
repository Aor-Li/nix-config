{ lib, hostConfig, ... }:
{
  # boot loader
  boot.loader = lib.mkIf (hostConfig.machine_type != "wsl") {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
}
