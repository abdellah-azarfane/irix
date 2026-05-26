{
  flake.nixosModules.zedextensions =
    {
      pkgs,
      config,
      inputs,
      lib,
      ...
    }:
    let
      user = config.preferences.user.name;
    in
    {
      home-manager.users.${user} = {
        programs.zed-editor = {
          extensions = [
            # language support
            "nix"
            "toml"
            "elixir"
            "sql"
            "graphql"
            "justfile"
            "nu"
            "julia"
            "elisp"
            "matlab"
            "log"
            "proto"
            "scss"
            "prisma"
            "fish"
            "meson"
            "xml"
            "csv"
            "latex"
            "lua"
            "zig"
            "make"
            "html"
            "biome"
            "ruff"
            "sqruff"
            "dockerfile"
            "python-lsp"
            # MCP
            # git support
            "git-firefly"
            # tools
            "rainbow-csv"
            "env"
            # themes
            "catppuccin-blur"
            "nightfox"
            # icons
            "phosphor-icons-theme"
            "catppuccin-icons"
          ];
        };
      };
    };
}
