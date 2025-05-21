{ pkgs, curUser, ... }: {
  imports = [];

  wsl = {
    enable = true;
    defaultUser = curUser;
    startMenuLaunchers = true;
  };

}