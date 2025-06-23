{ pkgs, inputs, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "24.11";

  # config substituters
  nix.settings.substituters = [
    "https://mirror.sjtu.edu.cn/nix-channels/store"
    "https://mirrors.ustc.edu.cn/nix-channels/store"
  ];

  # config nix-ld
  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };
}