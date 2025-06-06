{ nixpkgs, inputs, curUser, ... }: 
{
  imports = [];
  
  wsl = {
    enable = true;
    wslConf.automount.root = "/mnt";
    defaultUser = curUser;
    startMenuLaunchers = true;
  };
}