{ pkgs, lib, inputs, config, ... }:
{
  imports = [
    inputs.nixos-wsl.nixosModules.wsl
  ];

  wsl = {
    enable = true;
    defaultUser = "aor";  # Default user, can be overridden in host config
    startMenuLaunchers = true;
    wslConf.automount.root = "/mnt";
    # hostname is set in host config, so we don't need to set it here
  };
}
