{ userConfig, ... }:
{
  programs.git = {
    enable = true;
    userName = userConfig.full_name;
    userEmail = userConfig.email;
  };

  programs.lazygit.enable = true;
}
