{ ... }: {
  flake.nixosModules.lang-rust = { pkgs, config, ... }: {
    home-manager.users.${config.preferences.user.name} = {
      home.packages = with pkgs; [
        # --- Rust ---
        rustc # Rust compiler
        cargo # Rust package manager
        rustfmt # Rust formatter
        bacon # Rust background build tool
      ];
    };
  };
}
