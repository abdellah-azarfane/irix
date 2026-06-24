{
  flake.nixosModules.base = {lib, config, ...}: {
    options.preferences = {
      user.name = lib.mkOption {
        type = lib.types.str;
        default = "abosafiya";
      };

      optionalServices = lib.mkOption {
        type = lib.types.submodule {
          options = {
            greetd = lib.mkOption {
              type = lib.types.bool;
              default = true;
              description = "Enable greetd login manager.";
            };
          };
        };
        default = {};
        description = "Optional system services configuration.";
      };
    };
    config.sops.secrets."ssh_private_key" = {
          owner = "abosafiya";
          mode = "0600";
          path = "/home/abosafiya/.ssh/id_rsa_managed";
        };
  };
}
