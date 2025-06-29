{
  config,
  lib,
  hostConfig,
  ...
}:
{
  # 暂时将power.nix放在desktop目录下，后续可以根据需要调整
  config = lib.mkIf (hostConfig.machine_type == "desktop") {
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
