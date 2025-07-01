{ pkgs, inputs, ... }: 
let
  hostConfig = {
    machine_type = "wsl";
    host_name = "wsl-nixos-hw";
  };
in
{
  _module.args = {
    inherit hostConfig;
  };

  imports = [
    ../../../host/${hostConfig.machine_type}
  ];

  # config hw certification
  security.pki.certificateFiles = [
    ./certs/huawei_web_secure_internet_gateway.cer
  ];
}
