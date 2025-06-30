{
  config,
  lib,
  hostConfig,
  ...
}:
{
  config = lib.mkIf (hostConfig.machine_type == "server") {
    # Disable sleep on server
    systemd.sleep.extraConfig = ''
      [Sleep]
      AllowSuspend=no
      AllowHibernate=no
      AllowHybridSleep=no
      AllowSuspendThenHibernate=no
    '';
  };
}
