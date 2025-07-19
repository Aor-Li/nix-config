{ pkgs, inputs, ... }:
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  system.stateVersion = "25.11";

  # config substituters
  nix.settings.substituters = [
    "https://mirrors.sjtu.edu.cn/nix-channels/store"
    "https://mirrors.ustc.edu.cn/nix-channels/store"
    "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
  ];

  # config nix-ld
  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };
}
