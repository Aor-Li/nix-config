{ pkgs, inputs, ... } : 
{
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };
  
  system.stateVersion = "24.11";
}