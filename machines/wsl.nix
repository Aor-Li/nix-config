{ nixpkgs, inputs, curUser, ... }: 
{
  imports = [
    inputs.nixos-wsl.nixosModules.wsl
  ];

  wsl = {
    enable = true;
    wslConf.automount.root = "/mnt";
    defaultUser = curUser;
    startMenuLaunchers = true;
  };
}
