{ pkgs, inputs, ... }:
{
  # system environments
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    htop
  ];
  environment.variables.EDITOR = "vim";
}