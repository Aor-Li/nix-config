{ pkgs, inputs, ... }: 
{
  # config modules
  imports = [
    ../../../system
    ../../../system/wsl  # Import WSL-specific modules
  ];

  # Set the machine type
  system.machine_type = "wsl";

  # Set hostname
  networking.hostName = "wsl-nixos";
  
  # config hw certification
  security.pki.certificateFiles = [
    ./certs/huawei_web_secure_internet_gateway.cer
  ];
}
