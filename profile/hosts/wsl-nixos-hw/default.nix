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

  # config hw certification
  security.pki.certificateFiles = [
    ./certs/huawei_web_secure_internet_gateway.cer
  ];

  # config wsl
  wsl = {
    enable = true;
    wslConf.automount.root = "/mnt";
    startMenuLaunchers = true;
    defaultUser = "aor";
    wslConf.network.hostname = "wsl-nixos-hw";
  };
}
