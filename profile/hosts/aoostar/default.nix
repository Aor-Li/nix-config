{ pkgs, inputs, ... }: 
let
  hostConfig = {
    machine_type = "server";
    host_name = "aoostar";
  };
in 
{
  _module.args = {
    inherit hostConfig;
  };

  imports = [
    ./hardware-configuration.nix
    ./graphics.nix
    ../../../host/${hostConfig.machine_type}
  ];
}
