{ pkgs, inputs, ... }: 
{
  imports = [
    ./hardware-configuration.nix
    ../../../system
  ];
  system = {
    machine_type = "desktop";
    host_name = "aoostar";
  };
}
