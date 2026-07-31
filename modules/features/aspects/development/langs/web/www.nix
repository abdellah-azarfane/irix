{ ... }: {
  flake.nixosModules.lang-web = { pkgs, config, ... }: {
    home-manager.users.${config.preferences.user.name} = {
      home.packages = with pkgs; [
        # --- Javascript / Typescript / Runtimes ---
        nodejs
        typescript-language-server

        # --- Web Tooling & Formatters ---
        biome # Replaces Prettier & ESLint entirely
        vscode-langservers-extracted # Includes HTML, CSS, JSON
        plantuml

        jre       # Provides Java, required for PlantUML
        # --- Markup & Typography (Markdown & Typst) ---
        markdownlint-cli2
        marksman
        typst # Replaces LaTeX
        tinymist # Typst LSP
      ];
    };
  };
}
