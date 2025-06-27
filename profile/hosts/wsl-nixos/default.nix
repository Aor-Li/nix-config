{ pkgs, inputs, ... }: 
let 
  systemConfig = {
    hostname = "wsl-nixos";
    system = "x86_64-linux";
    machine_type = "wsl"; # "desktop", "server", "wsl"
    users = [ "aor" ];
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
}
