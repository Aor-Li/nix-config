{ lib, inputs, mylib, hostConfig, ... }:
{
  imports = [ 
    ../base
    inputs.nixos-wsl.nixosModules.wsl
  ] ++ mylib.scanPaths ./.;

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
