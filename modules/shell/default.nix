{ config, pkgs, ... }:
{
  programs.bash = {
    enable = true;
  };
  programs.fish = {
    enable = true;
  };
}