{ lib, hostConfig, inputs, ... }:
{
  imports = [
    inputs.nixos-wsl.nixosModules.wsl
  ];

  config = lib.mkIf (hostConfig.machine_type == "wsl") {
    wsl = {
      enable = true;
      startMenuLaunchers = true;
      wslConf.automount.root = "/mnt";
    };
  };
}
