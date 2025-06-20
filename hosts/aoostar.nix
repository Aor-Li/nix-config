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
    ./dm/plasma.nix
  ];

  # system environments
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
  ];
  environment.variables.EDITOR = "vim";
}
