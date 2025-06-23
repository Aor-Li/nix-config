{ pkgs, inputs, ...}: 
{
  imports = [
    ./nix_base.nix
    ./system_base.nix
  ];
}