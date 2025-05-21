{ nixpkgs, inputs, curUser, ... }: 
{
  wsl = {
    enable = true;
    defaultUser = curUser;
    startMenuLaunchers = true;
  };
}