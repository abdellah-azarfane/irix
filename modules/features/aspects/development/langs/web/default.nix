{ ... }: {
  flake.nixosModules.lang-web = { pkgs, config, ... }: {
    home-manager.users.${config.preferences.user.name} = {
      home.packages = with pkgs; [
        # --- Javascript / Typescript / Runtimes ---
        nodejs
        deno
        typescript-language-server

        # --- Frameworks (Vue, Svelte, React) ---
        vue-language-server
        svelte-language-server

        # --- Web Tooling & Formatters ---
        eslint
        prettier
        biome
        emmet-ls

        # --- HTML / CSS / Tailwinds ---
        vscode-langservers-extracted # Includes HTML, CSS, JSON, ESLint
        html-tidy
        dart-sass
        tailwindcss-language-server

        # --- Markup & Typography (Markdown, LaTeX, Typst, XML) ---
        markdownlint-cli2
        markdown-oxide
        marksman
        texlab
        texlivePackages.latexindent
        texlive.combined.scheme-full
        typst
        tinymist
        lemminx # XML

        # --- Data & APIs ---
        graphql-language-service-cli
        prisma_6
      ];
    };
  };
}
