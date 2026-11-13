{ ... }: {
  flake.nixosModules.lang-markdown = { pkgs, config, ... }: {
    home-manager.users.${config.preferences.user.name} = {
      home.packages = with pkgs; [
        # --- Markup & Typography (Markdown & Typst) ---
        markdownlint-cli2
        marksman
        typst # Replaces LaTeX
        tinymist # Typst LSP
      ];
    };
  };
}
