{
  inputs,
  sops-nix,
  userConfig,
  ...
}:
{
  # add sops-nix module
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  # config user secrets
  sops = {
    # The age key should be manually allocated to this location on the host
    # It is save in my 1password account
    age.keyFile = "/home/${userConfig.user_name}/.config/sops/age/keys.txt";

    # sops settings
    defaultSopsFile = ../../profile/users/${userConfig.user_name}/secrets/secrets.yaml;
    validateSopsFiles = false;
  };

}
