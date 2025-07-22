{
  config,
  pkgs,
  inputs,
  ...
}:
let
  userConfig = {
    user_name = "aor";
    full_name = "l00809570";
    email = "liyifeng17@hisilicon.com";
  };
in
{
  # pass user config to modules
  _module.args = {
    inherit userConfig;
  };

  # config modules
  imports = [
    ../../../user
  ];
}
