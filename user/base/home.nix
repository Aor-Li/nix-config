{ pkgs, inputs, userConfig, ... }:
{
  programs.home-manager.enable = true;
  home.username = userConfig.username;
  home.homeDirectory = "/home/${userConfig.username}";
  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.packages = [
    pkgs.fzf
    pkgs.lazygit
  ];
}