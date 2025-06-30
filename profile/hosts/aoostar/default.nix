{ pkgs, inputs, ... }: 
let
  hostConfig = {
    machine_type = "desktop";
    host_name = "aoostar";
  };
in 
{
  _module.args = {
    inherit hostConfig;
  };

  imports = [
    ./hardware-configuration.nix
    ../../../host/${hostConfig.machine_type}
  ];
}
