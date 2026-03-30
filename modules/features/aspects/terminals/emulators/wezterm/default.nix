{...}: {
  flake.nixosModules.wezterm = {pkgs, config, ...}:
  let
    user = config.preferences.user.name;
  in {
    environment.systemPackages = [pkgs.wezterm];

    hjem.users.${user}.files."wezterm/wezterm.lua" = {
      clobber = true;
      source = ./wezterm.lua;
    };
  };
}
