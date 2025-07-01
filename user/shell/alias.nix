{ pkgs, ... }:
let
    aliases = {
        ns = "sudo nixos-rebuild switch --flake ~/configs/nix-config";
        hs = "home-manager switch --flake ~/configs/nix-config";
    }; 
in
{
    programs.bash.shellAliases = aliases;
    programs.fish.shellAliases = aliases;
}
