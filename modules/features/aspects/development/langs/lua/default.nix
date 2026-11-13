{ ... }: {
  flake.nixosModules.lang-lua = { pkgs, config, lib, ... }: {
    home-manager.users.${config.preferences.user.name} = {
      home.packages = with pkgs; lib.flatten [
        # --- Scripting (Lua) ---
        lua-language-server
        stylua
      ];
    };
  };
}
