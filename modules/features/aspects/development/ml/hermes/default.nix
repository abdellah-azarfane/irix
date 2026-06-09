{ config, ... }: {
  flake.nixosModules.hermes = { config, ... }: {
    # Extract the secret
    sops.secrets."hermes_env" = {
      owner = "root";
    };

    services.hermes-agent = {
      enable = true;
      settings = {
              provider = "ollama";
              base_url = "http://127.0.0.1:11434/v1";
              model.default = "gemma4";
            };
    #  environmentFiles = [ config.sops.secrets."hermes_env".path ];
      addToSystemPackages = true;
    };
  };
}
