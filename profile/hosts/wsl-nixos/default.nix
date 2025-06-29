{ pkgs, inputs, ... }: 
let
  hostConfig = {
    machine_type = "wsl";
    host_name = "wsl-nixos";
  };
in 
{
  _module.args = {
    inherit hostConfig;
  };

  imports = [
    ../../../system
  ];
}