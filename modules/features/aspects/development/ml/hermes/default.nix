{ inputs, ... }: {

  flake.nixosModules.hermes = { config, lib, pkgs, ... }: {

    imports = [
      inputs.hermes-agent.nixosModules.default
    ];

      services.hermes-agent = {
      enable = true;

      settings.model = {
        provider = "ollama";
        base_url = "http://127.0.0.1:11434/v1";
        default = "gemma4";
      };

      # environmentFiles = [ config.sops.secrets."hermes_env".path ];

      addToSystemPackages = true;
    };
  };
}
