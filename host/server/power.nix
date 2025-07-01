{
  config,
  lib,
  hostConfig,
  ...
}:
{
  # Disable sleep on server
  systemd.sleep.extraConfig = ''
    [Sleep]
    AllowSuspend=no
    AllowHibernate=no
    AllowHybridSleep=no
    AllowSuspendThenHibernate=no
  '';
}
