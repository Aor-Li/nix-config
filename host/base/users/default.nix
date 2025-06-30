{ ... }:
{
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
