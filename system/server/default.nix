{ pkgs, lib, config, ... }:
{
  config = lib.mkIf (config.system.machine_type == "server") {
    # Server specific configuration goes here
    # For now it's empty, but you can add server-specific services, packages, etc.
  };
}
