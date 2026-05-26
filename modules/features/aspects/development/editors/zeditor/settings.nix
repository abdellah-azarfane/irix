{
  flake.nixosModules.zedsettings = { pkgs, config, inputs, lib,... }: let
    user = config.preferences.user.name;
  in {
    home-manager.users.${user} = {
      programs.zed-editor = {
          # Everything inside of these brackets are Zed options
          userSettings = {
            agent = {
              enabled = true;
              version = "2";
              default_open_ai_model = null;

              # Provider options:
              # - zed.dev models (claude-3-5-sonnet-latest) requires GitHub connected
              # - anthropic models (claude-3-5-sonnet-latest, claude-3-haiku-latest, claude-3-opus-latest) requires API_KEY
              # - copilot_chat models (gpt-4o, gpt-4, gpt-3.5-turbo, o1-preview) requires GitHub connected
              default_model = {
                provider = "zed.dev";
                model = "claude-3-5-sonnet-latest";
              };

              # inline_alternatives = [
              #   {
              #     provider = "copilot_chat";
              #     model = "gpt-3.5-turbo";
              #   }
              # ];
            };

            node = {
              path = lib.getExe pkgs.nodejs;
              npm_path = lib.getExe' pkgs.nodejs "npm";
            };

            # --- Behavior ---
            auto_indent_on_paste = true;
            auto_signature_help = true;
            cursor_blink = false;
            hide_mouse = "on_typing_and_action";
            hover_popover_delay = 350;
            hover_popover_enabled = true;
            middle_click_paste = true;
            show_completion_documentation = true;
            show_completions_on_input = true;
            show_edit_predictions = true;
            show_wrap_guides = true;
            use_autoclose = true;
            use_auto_surround = true;
            vim_mode = true;
            wrap_guides = [ ];


            hour_format = "hour24";
            auto_update = false;

            # --- Features And Telemetry ---
            edit_predictions = {
                provider = "copilot";
                 };

            telemetry = {
              diagnostics = false;
              metrics = true;
            };

            # --- Repl Configuration ---
            jupyter = {
              kernel_selections = {
                python = "nixpython";
              };
            };

            # Tell Zed to use direnv and direnv can use a flake.nix environment
            load_direnv = "shell_hook";
            base_keymap = "VSCode";
         };
        };
      };
    };
}
