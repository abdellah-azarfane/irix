{ inputs, pkgs }:
let
  inherit (inputs.nixCats) utils;

  # Root of the Neovim config that will be wrapped into the store when `wrapRc = true`.
  luaPath = ./.;

  categoryDefinitions = { pkgs, ... }@packageDef: {
    startupPlugins = {
      general = with pkgs.vimPlugins; [
        plenary-nvim
        telescope-nvim
        nvim-lspconfig
        (nvim-treesitter.withPlugins (p: [
          p.bash
          p.c
          p.css
          p.html
          p.javascript
          p.json
          p.lua
          p.markdown
          p.nix
          p.python
          p.rust
          p.toml
          p.typescript
          p.yaml
        ]))
      ];
    };

    lspsAndRuntimeDeps = {
      general = with pkgs; [
        ripgrep
        fd
        lua-language-server
        nil
      ];
    };
  };

  packageDefinitions = {
    nvim = { ... }: {
      settings = {
        wrapRc = true;
        aliases = [ "vi" "vim" ];
      };
      categories = {
        general = true;
      };
      extra = { };
    };
  };

  nixCatsBuilder = utils.baseBuilder luaPath { inherit pkgs; } categoryDefinitions packageDefinitions;
in
  nixCatsBuilder "nvim"
