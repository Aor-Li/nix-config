{ pkgs, inputs, ... }: 
let
  systemConfig = {
    hostname = "aoostar";
    system = "x86_64-linux";
    machine_type = "server"; # "desktop", "server", "wsl"
    users = [ "aor" ]; 
  };
in {
  _module.args = {
    inherit systemConfig;
  };
  imports = [
    ./hardware-configuration.nix
    ../../../system/base
  ];

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
