{
  inputs,
  lib,
  self,
  ...
}: {
  flake.lib.nvimWrapper = {
    config,
    wlib,
    lib,
    pkgs,
    ...
  }: let
    selfpkgs = self.packages."${pkgs.stdenv.hostPlatform.system}";
  in {
    imports = [wlib.wrapperModules.neovim];

    # REMOVED the crashing config.nixpkgs.config... line from here.

    options.settings.test_mode = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        If true, use impure config instead for fast edits

        Both versions of the package may be installed simultaneously
      '';
    };
    config.env.LADSPA_PATH = "${pkgs.deepfilternet}lib/ladspa/libdeep_filter_ladspa.so";
    config.settings.config_directory =
      if config.settings.test_mode
      then config.settings.unwrapped_config
      else config.settings.wrapped_config;
    options.settings.wrapped_config = lib.mkOption {
      type = wlib.types.stringable;
      default = ./.;
    };
    options.settings.unwrapped_config = lib.mkOption {
      type = lib.types.either wlib.types.stringable lib.types.luaInline;
      default = lib.generators.mkLuaInline "vim.uv.os_homedir() .. '/nixconf/modules/wrappedPrograms/neovim'";
    };
    config.settings.dont_link = config.binName != "nvim";
    config.binName = lib.mkIf config.settings.test_mode (lib.mkDefault "vim");
    config.settings.aliases = lib.mkIf (config.binName == "nvim") ["vi"];

    config.specs.initLua = {
      data = null;
      before = ["MAIN_INIT"];
      config = ''
        require('init')
        require('lz.n').load('plugins')
      '';
    };

    config.extraPackages = [
      pkgs.lua-language-server
      pkgs.astro-language-server
      pkgs.typescript-language-server
      pkgs.rust-analyzer
      pkgs.kdePackages.qtdeclarative
      pkgs.nixd
      pkgs.alejandra
      pkgs.ffmpeg-full
      selfpkgs.vjxl-format

      # --- External System Tools for Plugins ---
      pkgs.ripgrep        # Needed for Snacks/Telescope grep
      pkgs.fd             # Needed for Snacks/Telescope file finding
      pkgs.yazi           # Needed for yazi-nvim
      pkgs.zathura        # Viewer for vimtex
      pkgs.texliveMedium  # LaTeX compiler (use texliveFull if needed)
      pkgs.typst          # Compiler for typst-preview
      pkgs.imagemagick    # Needed for image-nvim
    ];

    config.specs.start = let
      p = pkgs.vimPlugins;
      vjxl-grammar = pkgs.tree-sitter.buildGrammar {
        language = "vjxl";
        version = "0.0.1";
        src = ./vjxl-ts;
      };
    in [
      p.lz-n
      p.plenary-nvim
      p.nvim-lspconfig
      p.nvim-treesitter.withAllGrammars
      (p.nvim-treesitter.grammarToPlugin vjxl-grammar)

      # completion
      p.nvim-web-devicons
      p.lspkind-nvim
      p.colorful-menu-nvim
      p.blink-cmp
      p.friendly-snippets

      # misc
      p.snacks-nvim
      p.oil-nvim
      p.luasnip

      # --- UI & Visuals ---
      p.catppuccin-nvim
      p.tokyonight-nvim
      p.bufferline-nvim
      p.lualine-nvim
      p.noice-nvim
      p.nui-nvim # Dependency for noice
      p.dashboard-nvim
      p.indent-blankline-nvim
      p.nvim-colorizer-lua
      p.tiny-inline-diagnostic-nvim
      p.vim-illuminate

      # --- Editor & Navigation ---
      p.flash-nvim
      p.multicursors-nvim
      p.harpoon
      p.aerial-nvim
      p.trouble-nvim
      p.todo-comments-nvim
      p.which-key-nvim
      p.yazi-nvim
      p.zen-mode-nvim
      p.marks-nvim
      p.nvim-spectre
      p.comment-nvim
      p.conform-nvim # For formatting

      # --- Languages, Math & Note-taking ---
      p.vimtex
      p.render-markdown-nvim
      p.markdown-preview-nvim
      p.typst-preview-nvim
      p.molten-nvim # Jupyter notebooks in nvim
      p.image-nvim  # For viewing images inside nvim
      p.vim-nix
      p.vim-go

      # --- Git / Version Control ---
      p.octo-nvim
      p.gitsigns-nvim

      # --- Treesitter Extras ---
      p.nvim-treesitter-context
      p.nvim-treesitter-textobjects

      # --- KMonad ---
      p.kmonad-vim
    ];

    config.specs.opt = let
      p = pkgs.vimPlugins;
    in {
      lazy = true;
      data = [
        p.lazydev-nvim
        p.gitsigns-nvim
        p.nvim-autopairs
        p.fastaction-nvim
        p.mini-files
        p.codecompanion-nvim
      ];
    };
  };

  perSystem = {
    system, # <-- ADDED 'system' so inputs.nixpkgs can use it
    pkgs,
    self',
    ...
  }: {
    # --- THE FIX: Instantiate pkgs globally for all perSystem outputs ---
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "wezterm.nvim"
        "vimplugin-wezterm.nvim"
      ];
    };
    # --------------------------------------------------------------------

    packages.neovim = inputs.wrapper-modules.wrappers.neovim.wrap {
      inherit pkgs;
      imports = [self.lib.nvimWrapper];
    };
    packages.devMode = inputs.wrapper-modules.wrappers.neovim.wrap {
      inherit pkgs;
      settings.test_mode = true;
      imports = [self.lib.nvimWrapper];
    };

    packages.neovimDynamic = pkgs.writeShellApplication {
      name = "nvim";
      text = ''
        if [ -d ~/irix/modules/features/wrappedPrograms/neovim/lua ]; then
            # start dev mode
            ${lib.getExe self'.packages.devMode} "$@"
        else
            # start normal mode
            ${lib.getExe self'.packages.neovim} "$@"
        fi
      '';
    };

    packages.vjxl-grammar = pkgs.tree-sitter.buildGrammar {
      language = "vjxl";
      version = "0.0.1";
      src = ./vjxl-ts;
    };

    packages.vjxl-format = let
      config = pkgs.writeText "topiary-config.ncl" ''
        {
          languages.vjxl = {
            extensions = ["vjxl"],
            grammar.source.path = "${self'.packages.vjxl-grammar}/parser",
          },
        }
      '';
    in
      pkgs.writeShellScriptBin "format-vjxl" ''
        sed -E 's/[[:space:]]+/ /g' \
        | TOPIARY_LANGUAGE_DIR=${./topiary-queries} \
        ${pkgs.topiary}/bin/topiary \
            --config ${config} \
            format \
            --language vjxl \
            --skip-idempotence
      '';
  };
}
