{ pkgs, inputs, ... }: 
{
  imports = [
    ../../../system
  ];
  system = {
    machine_type = "wsl";
    host_name = "wsl-nixos-hw";
  };

  # config hw certification
  security.pki.certificateFiles = [
    ./certs/huawei_web_secure_internet_gateway.cer
  ];
}
