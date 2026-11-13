{ ... }: {
  flake.nixosModules.lang-javascript = { pkgs, config, ... }: {
    home-manager.users.${config.preferences.user.name} = {
      home.packages = with pkgs; [
        # --- Javascript / Typescript / Runtimes ---
        nodejs
        typescript-language-server
      ];
    };
  };
}
