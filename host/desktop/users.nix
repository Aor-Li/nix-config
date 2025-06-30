{
  config,
  lib,
  pkgs,
  hostConfig,
  ...
}:
{
  config = lib.mkIf (hostConfig.machine_type == "desktop") {
    # Configure the aor user for desktop and remote access
    users.users.aor = {
      isNormalUser = true;
      description = "aor";
      extraGroups = [ 
        "wheel"         # Allow sudo
        "networkmanager" # Network management
        "audio"         # Audio access
        "video"         # Video access
        "input"         # Input devices
        "docker"        # Docker (if needed)
      ];
      
      # Enable password authentication for remote desktop
      # Note: You should change this password after system rebuild using 'passwd aor'
      # Current password is: password123 (please change it immediately after login)
      hashedPassword = "$6$oI3FhBd1DC6uGc2h$txK4vhN63Z8anh0MlKCzcenIVHgUE4kKBpv5RheUawNv3ZlGnFoq2R/BmipXniHWRW4WLySCUbnPYHSurWD08/";
      
      # Default shell
      shell = pkgs.bash;
    };

    # Ensure necessary services are available for desktop users
    services.accounts-daemon.enable = true;
    
    # Enable automatic login for the console (but not for remote sessions)
    services.getty.autologinUser = lib.mkDefault "aor";
  };
}
