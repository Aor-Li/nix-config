{ lib, hostConfig, ... }:
lib.mkIf (hostConfig.machine_type == "desktop") {
  # Enable X11 windowing system
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
  };

  # Enable the KDE Plasma Desktop Environment
  services.desktopManager.plasma6.enable = true;

  # Enable SDDM display manager
  services.displayManager = {
    sddm.enable = true;
    autoLogin = {
      enable = true;
      user = "aor";
    };
  };

  # Enable sound with pipewire for better audio experience
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (for laptops)
  services.xserver.libinput.enable = true;

  # Enable printing services
  services.printing.enable = true;

  # Enable NetworkManager for network management
  networking.networkmanager.enable = true;

  # Enable Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Install essential desktop packages
  environment.systemPackages = with pkgs; [
    # KDE Applications
    kdePackages.kate
    kdePackages.konsole
    kdePackages.dolphin
    kdePackages.gwenview
    kdePackages.okular
    kdePackages.ark
    kdePackages.kdeconnect-kde

    # Web browsers
    firefox

    # Media
    vlc

    # System utilities
    htop
    neofetch
    tree

    # File management
    unzip
    zip

    # Network utilities
    wget
    curl
  ];

  # Enable flatpak for additional software
  services.flatpak.enable = true;

  # Configure fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
  ];
}
