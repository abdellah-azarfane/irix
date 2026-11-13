{ ... }: {
  flake.nixosModules.lang-web = { pkgs, config, ... }: {
    home-manager.users.${config.preferences.user.name} = {
      home.packages = with pkgs; [
        # --- Web Tooling & Formatters ---
        biome # Replaces Prettier & ESLint entirely
        vscode-langservers-extracted # Includes HTML, CSS, JSON
        plantuml

        jre       # Provides Java, required for PlantUML
      ];
    };
  };
}
