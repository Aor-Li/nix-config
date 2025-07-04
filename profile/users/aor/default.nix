{
  config,
  pkgs,
  inputs,
  ...
}:
let
  userConfig = {
    user_name = "aor";
    full_name = "Aor-Li";
    email = "liyifeng0039@gmail.com";
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
