{...}: {
  flake.nixosModules.wezterm = {pkgs, config, ...}:
  let
    user = config.preferences.user.name;
  in {
    environment.systemPackages = [pkgs.wezterm];

    home-manager.users.${user} = {
      xdg.configFile = {"wezterm/wezterm.lua"source = ./wezterm.lua;
    };
  };
}
