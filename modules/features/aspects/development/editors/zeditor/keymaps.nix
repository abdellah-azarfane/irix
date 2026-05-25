{
  flake.nixosModules.zedkeymaps = { pkgs, config, inputs, lib,... }: let
    user = config.preferences.user.name;
  in {
    home-manager.users.${user} = {
      programs.zed-editor = {
        userSettings = {
          userKeymaps = [
            {
              context = "Workspace";
              bindings = {
                "ctrl-b" = "workspace::ToggleLeftDock";
                "alt-tab" = "project_panel::ToggleFocus";
              };
            }
            {
              context = "Editor";
              bindings = {
                "ctrl-b" = "workspace::ToggleLeftDock";
              };
            }
            {
              context = "Editor && vim_mode == normal || vim_mode == visual";
              bindings = {
                "space c" = "editor::ToggleComments";
              };
            }
            {
              context = "Editor && language == python";
              bindings = {
                "ctrl-shift-enter" = "repl::Run";
                "shift-enter" = "repl::Run";
                "ctrl-shift-c" = "repl::ClearOutputs";
                "alt-enter" = [ "repl::Run" "editor::MoveDown" ];
              };
            }
          ];
        };
      };
    };
  };
}
