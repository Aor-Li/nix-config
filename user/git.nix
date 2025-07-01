{ userConfig, ... }:
{
  programs.git = {
    enable = true;
    userName = userConfig.full_name;
    userEmail = userConfig.email;
  };
}
