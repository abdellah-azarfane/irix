{}:{
  flake.nixosModules.sops = { pkgs, config, lib, ...}: {
        imports = [
          inputs.nix-index-database.nixosModules.nix-index
          inputs.sops-nix.nixosModules.sops
        ];

        sops = {

          defaultSopsFile = ../../../../../secrets/secrets.yaml;
          defaultSopsFormat = "yaml";
          age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
        };

        environment.systemPackages = [ pkgs.sops ];
      };
    }
  };
}
