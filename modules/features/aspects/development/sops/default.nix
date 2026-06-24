{
  flake.nixosModules.sops = { pkgs, config, lib, inputs, ...}: {
        imports = [
          inputs.sops-nix.nixosModules.sops
        ];

        sops = {
          defaultSopsFile = ../../../../../secrets/secrets.yaml;
          defaultSopsFormat = "yaml";
          age.sshKeyPaths = [ config.preferences.sops.sshdKeyPath ];
        };

        environment.systemPackages = [ pkgs.sops ];
      };
  }
