{ ... }: {
  flake.nixosModules.lang-devops = { pkgs, config, lib, ... }: {
    home-manager.users.${config.preferences.user.name} = {
      home.packages = with pkgs; lib.flatten [
        # --- DevOps & Configs ---
        dockerfile-language-server
        sqlfluff
        sqlite
        sqls
        taplo # TOML
        yaml-language-server
        just
        just-lsp
      ];
    };
  };
}
