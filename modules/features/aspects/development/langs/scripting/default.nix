{ ... }: {
  flake.nixosModules.lang-scripting = { pkgs, config, ... }: {
    home-manager.users.${config.preferences.user.name} = {
      home.packages = with pkgs; [
        # --- Shell Scripting ---
        bash-language-server
        shfmt
        shellcheck
        fish-lsp

        # --- Python (With Molten/Jupyter Environment) ---
        isort
        pyright
        ruff
        poetry
        (python3.withPackages (ps: with ps; [
          ipykernel jupyter jupyter-client cairosvg kaleido nbformat pillow plotly
          pynvim pyperclip matplotlib numpy pandas wcwidth black pyflakes pipenv pytest grip
        ]))

        # --- Functional (Clojure, Haskell, OCaml, Elixir, Elm, Lisp) ---
        clojure-lsp cljfmt clj-kondo
        sbcl # Common Lisp
        haskell-language-server haskellPackages.fourmolu haskellPackages.cabal-install haskellPackages.hoogle
        ocamlPackages.ocaml-lsp ocamlPackages.ocamlformat ocamlPackages.dune_3 ocamlPackages.utop ocamlPackages.ocp-indent ocamlPackages.merlin
        elixir elixir-ls erlang-language-platform erlfmt
        elmPackages.elm-format elmPackages.elm-language-server

        # --- Math & Data (R, Julia, Faust) ---
        rPackages.styler rPackages.languageserver
        julia
        faust

        # --- Scripting (Lua, Perl, PHP, Fennel) ---
        lua-language-server stylua
        perlnavigator
        intelephense # PHP
        fennel-ls

        # --- DevOps, Configs, & Infrastructure ---
        dockerfile-language-server dockfmt
        terraform-ls
        sqlfluff sqlite sqls
        dhall dhall-lsp-server
        jinja-lsp jinja2-cli
        taplo # TOML
        yaml-language-server
        kdlfmt
        just just-lsp

        # --- General Utilities ---
        devenv
        graphviz
        prettierd # Daemonized Prettier
        rlwrap
        socat
        tree-sitter
      ];
    };
  };
}
