{ pkgs, inputs, ... }: 
{
  # config modules
  imports = [
    ../../../system
    ../../../system/wsl  # Import WSL-specific modules
  ];

  # Set the machine type
  system.machine_type = "wsl";

  # Set hostname
  networking.hostName = "wsl-nixos";

  # wsl config
  wsl = {
    enable = true;
    defaultUser = "aor";
    startMenuLaunchers = true;
    wslConf.automount.root = "/mnt";
    wslConf.network.hostname = "wsl-nixos";
  };
}
