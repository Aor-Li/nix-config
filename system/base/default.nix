{ pkgs, inputs, ... }:
{
  imports = [
    ./nix
    ./core
    ./shell
    #./network
  ];
}