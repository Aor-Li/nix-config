{ pkgs, inputs, ... }: 
{
  imports = [
    ../../../system
  ];
  system = {
    machine_type = "wsl";
    host_name = "wsl-nixos";
  };
}