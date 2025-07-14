{
  pkgs,
  inputs,
  userConfig,
  ...
}:
{
  programs.home-manager.enable = true;
  home.username = userConfig.user_name;
  home.homeDirectory = "/home/${userConfig.user_name}";
  home.stateVersion = "25.05"; # Please read the comment before changing.
}
