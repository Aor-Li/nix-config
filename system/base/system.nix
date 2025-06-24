{ pkgs, inputs, ... }:
{
  # system environments
  environment.systemPackages = with pkgs; [
    git
    vim
    htop
    wget
    coreutils
  ];
  environment.variables.EDITOR = "vim";
  
  services.timesyncd.servers = [ "time.cloudflare.com" ];
}