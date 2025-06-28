{ pkgs, lib, hostConfig, ... }:
{
  config = lib.mkIf (hostConfig.machine_type == "server") {
    # Server specific configuration goes here
    # For now it's empty, but you can add server-specific services, packages, etc.
  };
}
