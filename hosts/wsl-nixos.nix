{ pkgs, inputs, curUser, ... }: 
{
  # config nix functions
  nix.settings.substituters = [
    "https://mirror.sjtu.edu.cn/nix-channels/store"
    "https://mirrors.ustc.edu.cn/nix-channels/store"
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };
  system.stateVersion = "24.11";

  # config modules
  imports = [
    inputs.nixos-wsl.nixosModules.wsl
    ./dm/plasma.nix
  ];
  wsl = {
    enable = true;
    wslConf.automount.root = "/mnt";
    defaultUser = curUser;
    startMenuLaunchers = true;
  };

  # system environments
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
  ];
  environment.variables.EDITOR = "vim";
}
