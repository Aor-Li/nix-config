{ nixpkgs, inputs, curUser, ... }: 
{
  imports = [];

  options.wsl = {
    enable = true;
    defaultUser = curUser;
    startMenuLaunchers = true;
  };
}