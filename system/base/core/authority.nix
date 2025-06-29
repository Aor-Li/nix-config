{ hostConfig, ... }:
{
  # users - define default user for now
  users = {
    users.aor = {
      isNormalUser = true;
      description = "aor";
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
    };
  };
}
