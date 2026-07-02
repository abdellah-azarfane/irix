{ ... }: {
  flake.nixosModules.lang-scripting = { pkgs, config, lib, ... }: {
    home-manager.users.${config.preferences.user.name} = {
      home.packages = with pkgs; lib.flatten [
        # --- Shell & Core Scripting ---
        bash-language-server
        shfmt
        shellcheck

        # --- Python (Editor Support Only - Runtimes go in project flakes) ---
        pyright
        ruff

        # --- Scripting (Lua) ---
        lua-language-server
        stylua

        # --- DevOps & Configs ---
        dockerfile-language-server
        sqlfluff
        sqlite
        sqls
        taplo # TOML
        yaml-language-server
        just
        just-lsp

        # --- General Utilities & Infrastructure ---
        devenv
        graphviz
        prettierd
        rlwrap
        socat
        tree-sitter
      ];
    };
  };
}
