{
  pkgs,
  inputs,
  userConfig,
  ...
}:
{
  # home-manager settings
  programs.home-manager.enable = true;
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # user settings
  home.username = userConfig.user_name;
  home.homeDirectory = "/home/${userConfig.user_name}";
}
