{ lib, config, ... }: 
{
  options.system = {
    machine_type = lib.mkOption {
      type = lib.types.enum [ "desktop" "server" "wsl" ];
      description = "The type of machine this configuration is for"; 
    };
    host_name = lib.mkOption {
      type = lib.types.str;
      description = "The hostname of the machine"; 
    };
  };

  imports = [
    ./base
    ./wsl
    ./desktop  
    ./server
  ];
  
  config = {
    networking.hostName = config.system.host_name;
  };
}