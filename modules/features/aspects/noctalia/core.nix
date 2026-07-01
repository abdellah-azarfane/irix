{ self, ... }: {
  flake.nixosModules.noctalia =
    {
      inputs,
      config,
      pkgs,
      lib,
      ...
    }:
    let
      user = config.preferences.user.name;
      sys = pkgs.stdenv.hostPlatform.system;
    in
    {
      imports = [
        self.nixosModules.noctalia-plugins
      ];
      home-manager.users.${user} = {
        imports = [
          inputs.noctalia.homeModules.default
        ];
        programs.noctalia = {
          enable = true;
          settings = {
            theme = {
              mode = "dark";
              source = "builtin";
              builtin = "Catppuccin";
            };
            wallpaper = {
              enabled = true;
            };
            bar.main = {
              position = "top";
            };
            shell = {
              ui_scale = 1.0;
              clipboard_enabled = true;
            };
          };
          systemd.enable = true;
        };
      };
    };
}
