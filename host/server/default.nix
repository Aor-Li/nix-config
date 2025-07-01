{ mylib, ... }:
{
  imports = [ ../desktop ] ++ mylib.scanPaths ./.;
}