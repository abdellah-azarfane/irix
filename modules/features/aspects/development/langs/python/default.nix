{ ... }: {
  flake.nixosModules.lang-python = { pkgs, config, lib, ... }: {
    home-manager.users.${config.preferences.user.name} = {
      home.packages = with pkgs; lib.flatten [
        # --- Python (Editor Support Only - Runtimes go in project flakes) ---
        pyright
        ruff
      ];
    };
  };
}
