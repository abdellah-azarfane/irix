{ ... }: {
  flake.nixosModules.lang-utilities = { pkgs, config, lib, ... }: {
    home-manager.users.${config.preferences.user.name} = {
      home.packages = with pkgs; lib.flatten [
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
