{ lib, ... }: 
let
  machineTypeModules = {
    desktop = [ ./desktop ];
    server = [ ./server ];
    wsl = [ ./wsl ];
  };
in
{
  # Define the machine_type option
  options.system.machine_type = lib.mkOption {
    type = lib.types.enum [ "desktop" "server" "wsl" ];
    description = "The type of machine this configuration is for";
  };

  imports = [
    ./base
  ];
}