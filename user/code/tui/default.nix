{ pkgs, mylib, ... }:
{
  imports = mylib.scanPaths ./.;

  home.packages = with pkgs; [
    fzf
    tree
    btop
  ];
}
