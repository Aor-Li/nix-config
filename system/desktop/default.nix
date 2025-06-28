{ pkgs, lib, hostConfig, ... }:
{
  config = lib.mkIf (hostConfig.machine_type == "desktop") {
    # Desktop specific configuration goes here
    # For now it's empty, but you can add desktop-specific services, packages, etc.
  };
}
