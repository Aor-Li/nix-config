{ lib, ... }:
{
  # config starship
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    settings = lib.importTOML ./catppuccin-powerline.toml;
  };
}
