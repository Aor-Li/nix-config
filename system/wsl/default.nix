{ lib, config, inputs, ... }:
{
  imports = [
    inputs.nixos-wsl.nixosModules.wsl
  ];

  config = lib.mkIf (config.system.machine_type == "wsl") {
    wsl = {
      enable = true;
      startMenuLaunchers = true;
      wslConf.automount.root = "/mnt";
    };
  };
}
