{
  flake.nixosModules.zedterminal = { pkgs, config, inputs, lib,... }: let
    user = config.preferences.user.name;
  in {
    home-manager.users.${user} = {
      programs.zed-editor = {
         userSettings = {
           terminal = {
             alternate_scroll = "off";
             blinking = "off";
             copy_on_select = false;
             dock = "bottom";
             detect_venv = {
               on = {
                 directories = [ ".env" "env" ".venv" "venv" ];
                 activate_script = "default";
               };
             };
             env = {
               TERM = "kitty";
             };
             font_family = "FiraCode Nerd Font";
             font_features = null;
             font_size = null;
             line_height = "comfortable";
             option_as_meta = false;
             button = false;
             shell = "system";
             toolbar = {
               title = true;
             };
             working_directory = "current_project_directory";
           };
        };
      };
    };
  };
}
