let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in
  pkgs.mkShell {
    packages = with pkgs; [
      # output shell info
      cowsay
      lolcat
      # base
      gnumake
      cmake
      pkg-config
      # requirements for less_slow_cpp
      liburing
      openblas
    ];
  }
