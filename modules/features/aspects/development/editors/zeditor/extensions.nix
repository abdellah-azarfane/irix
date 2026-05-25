{
  flake.nixosModules.zedextensions = { pkgs, config, inputs, lib,... }: let
    user = config.preferences.user.name;
  in {
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
          "toml"
          "log"
          "proto"
          "scss&sass"
          "prisma"
          "fish"
          "meson"
          "xml"
          "csv"
          "latex"
          "scss"
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
          "git firefly"
          # tools
          "rainbow-csv"
          "env"
          # themes
          "catpuccin-blur"
          "nightfox-themes-opaque/blurred"
          # icons
          "phosphor-icons-theme"
          "catpuccin icons"
        ];
      };
    };
  };
}
