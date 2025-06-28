{ pkgs, lib, config, ... }:
{
  config = lib.mkIf (config.system.machine_type == "desktop") {
    # Desktop specific configuration goes here
    # For now it's empty, but you can add desktop-specific services, packages, etc.
  };
}
