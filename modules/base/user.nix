{
  flake.nixosModules.base = { lib, config, ... }: {
    options.preferences = {
      user.name = lib.mkOption {
        type = lib.types.str;
        default = "abosafiya";
      };

      optionalServices = lib.mkOption {
        description = "Optional system services configuration.";
        default = { };
        type = lib.types.submodule {
          options = {
            greetd = lib.mkOption {
              type = lib.types.bool;
              default = false;
              description = "Enable the standard greetd login manager.";
            };

            noctalia-greeter = lib.mkOption {
              type = lib.types.bool;
              default = false;
              description = "Enable the Noctalia-specific login manager.";
            };
          };
        };
      };

      sops = {
        sshKeyPath = lib.mkOption {
          type = lib.types.str;
          default = "/home/abosafiya/.ssh/id_rsa_managed";
          description = "Path to store the SOPS-managed SSH private key.";
        };

        sshdKeyPath = lib.mkOption {
          type = lib.types.str;
          default = "/etc/ssh/ssh_host_ed25519_key";
          description = "Path to the SSH host key used for SOPS age decryption.";
        };
      };
    };

    config = {
      sops.secrets."ssh_private_key" = {
        owner = config.preferences.user.name;
        mode = "0600";
        path = config.preferences.sops.sshKeyPath;
      };
    };
  };
}
