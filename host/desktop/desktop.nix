{ pkgs, hostConfig, ... }:
{
  # Enable Wayland
  services.xserver.enable = true;
  services.displayManager.defaultSession = "plasma";

  # Enable the KDE Plasma Desktop Environment with Wayland
  services.desktopManager.plasma6.enable = true;

  # Enable SDDM display manager with Wayland support
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
    };
    autoLogin = {
      enable = true;
      user = "aor";
    };
  };

  # Keyboard layout
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable sound with pipewire for better audio experience
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (for laptops)
  services.libinput.enable = true;

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
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
  ];
}
