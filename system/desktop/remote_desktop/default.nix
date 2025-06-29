{
  pkgs,
  mylib,
  ...
}:
{
  imports = mylib.scanPaths ./.;

  environment.systemPackages = with pkgs; [
    waypipe
  ];
}
