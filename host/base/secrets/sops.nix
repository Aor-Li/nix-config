{
  inputs,
  pkgs,
  userConfig,
  ...
}:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  environment.systemPackages = with pkgs; [
    sops
    age
  ];

  # set host secrets below
}
