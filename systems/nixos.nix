{ pkgs, inputs, ... } : 
{
  # nix settings
  nix.settings.substituters = [
    "https://mirror.sjtu.edu.cn/nix-channels/store"
    "https://mirrors.ustc.edu.cn/nix-channels/store"
    "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };
  system.stateVersion = "24.11";

  # system environments
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
  ];
  environment.variables.EDITOR = "vim";
}