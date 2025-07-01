{ mylib, ... }:
{
  imports = mylib.scanPaths ./.;
  programs.bash.enable = true;
  programs.fish.enable = true;
}
