{ pkgs, inputs, ... }: 
{
  imports = [
    ./hardware-configuration.nix
    ../../../system
    ../../../system/server  # Import server-specific modules
  ];

  # Set the machine type
  system.machine_type = "server";

  # Set hostname
  networking.hostName = "aoostar";

  # # Configure keymap in X11
  # services.xserver.xkb = {
  #   layout = "us";
  #   variant = "";
  # };
# 
  # # Enable sound with pipewire.
  # hardware.pulseaudio.enable = false;
  # security.rtkit.enable = true;
  # services.pipewire = {
  #   enable = true;
  #   alsa.enable = true;
  #   alsa.support32Bit = true;
  #   pulse.enable = true;
  # };
  
  

}
