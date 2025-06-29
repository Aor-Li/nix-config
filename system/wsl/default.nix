{ lib, inputs, mylib, hostConfig, ... }:
{
  imports = mylib.scanPaths ./. ++ [
    inputs.nixos-wsl.nixosModules.wsl
  ];

  config = lib.mkIf (hostConfig.machine_type == "wsl") {
    wsl = {
      enable = true;
      defaultUser = "aor";
      startMenuLaunchers = true;
      wslConf.automount.root = "/mnt";
      wslConf.network.hostname = hostConfig.host_name;
    };
  };
}
