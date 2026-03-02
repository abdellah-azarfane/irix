{
  flake.modules.homeManager.neovim =
    {
      pkgs,
      lib,
      inputs,
      ...
    }:
    let
      # 1. THE BRIDGE
      nvimWrapperConfig =
        {
          config,
          wlib,
          lib,
          pkgs,
          ...
        }:
        {
          # We import your massive module.nix file right here!
          imports = [
            wlib.wrapperModules.neovim
            (import ./_module.nix inputs)
          ];

          # We keep the Live-Edit paths here so they don't clutter your config
          options.settings.test_mode = lib.mkOption {
            type = lib.types.bool;
            default = false;
          };
          options.settings.wrapped_config = lib.mkOption {
            type = wlib.types.stringable;
            default = ./.;
          };
          options.settings.unwrapped_config = lib.mkOption {
            type = lib.types.either wlib.types.stringable lib.types.luaInline;
            default = lib.generators.mkLuaInline "vim.uv.os_homedir() .. '/irix/modules/programs/editors/neovim'";
          };
          config.settings.config_directory =
            if config.settings.test_mode then
              config.settings.unwrapped_config
            else
              config.settings.wrapped_config;
          config.settings.dont_link = config.binName != "nvim";
          config.binName = lib.mkIf config.settings.test_mode (lib.mkDefault "vim");
          config.settings.aliases = lib.mkIf (config.binName == "nvim") [ "vi" ];
        };

      # 2. BUILD THE PACKAGES
      neovimNormal = inputs.wrapper-modules.wrappers.neovim.wrap {
        inherit pkgs;
        imports = [ nvimWrapperConfig ];
      };

      neovimDevMode = inputs.wrapper-modules.wrappers.neovim.wrap {
        inherit pkgs;
        settings.test_mode = true;
        imports = [ nvimWrapperConfig ];
      };

      # 3. DYNAMIC SWITCHER
      neovimDynamic = pkgs.writeShellApplication {
        name = "nvim";
        text = ''
          if [ -d ~/irix/modules/programs/editors/neovim/lua ]; then
               ${lib.getExe neovimDevMode} "$@"
           else
               ${lib.getExe neovimNormal} "$@"
           fi
        '';
      };

    in
    {
      home.packages = [ neovimDynamic ];
      home.sessionVariables.EDITOR = "nvim";
    };
}
