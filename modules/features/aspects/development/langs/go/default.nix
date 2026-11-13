{ ... }: {
  flake.nixosModules.lang-go = { pkgs, config, ... }: {
    home-manager.users.${config.preferences.user.name} = {
      home.packages = with pkgs; [
        # --- Go (Lean API support) ---
        go
        gopls
      ];
    };
  };
}
