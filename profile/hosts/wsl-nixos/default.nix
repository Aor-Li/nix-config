{ pkgs, inputs, ... }: 
let 
  systemConfig = {
    hostname = "wsl-nixos";
    system = "x86_64-linux";
  };
in {

  # pass system config to modules
  _module.args = {
    inherit systemConfig;
  };

  # config modules
  imports = [
    inputs.nixos-wsl.nixosModules.wsl
    ../../../system/base
  ];

  wsl = {
    enable = true;
    defaultUser = "aor";
    startMenuLaunchers = true;
    wslConf.automount.root = "/mnt";
    wslConf.network.hostname = systemConfig.hostname;
  };
}
