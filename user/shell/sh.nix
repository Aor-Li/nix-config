{ pkgs, ... }:
let
    myAliases = {
        ns = "sudo nixos-rebuild switch --flake ~/configs/nix-config";
        hs = "home-manager switch --flake ~/configs/nix-config";
    };
in
{
    # config bash
    programs.bash = {
        enable = true;
        enableCompletion = true;
        shellAliases = myAliases;
    };

    # config fish
    programs.fish = {
        enable = true;
    };
}