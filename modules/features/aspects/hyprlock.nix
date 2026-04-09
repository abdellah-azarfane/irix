{
 flake.nixosModules.hyprlock = { pkgs, config, ... }:
  let
    user = config.preferences.user.name;
  in {
    home-manager.users.${user} = {
      programs.hyprlock = {
        enable = true;

        settings = {
          # -----------------------------------------------------
          # 1. GENERAL & AUTHENTICATION
          # -----------------------------------------------------
          general = {
            disable_loading_bar = false;
            hide_cursor = true;
            grace = 0; # Seconds to unlock on mouse move without password
            ignore_empty_input = false;
            immediate_render = false;
            text_trim = true;
            fractional_scaling = 2; # 0: disabled, 1: enabled, 2: auto
            screencopy_mode = 0; # 0: GPU, 1: CPU (slow)
          };

          auth = {
            "pam:enabled" = true;
            "pam:module" = "hyprlock";
            "fingerprint:enabled" = false;
            "fingerprint:ready_message" = "(Scan fingerprint to unlock)";
            "fingerprint:present_message" = "Scanning fingerprint";
          };

          # -----------------------------------------------------
          # 2. BACKGROUND WIDGET (List)
          # -----------------------------------------------------
          background = [
            {
              monitor = ""; # Empty means all monitors
              path = "/home/${user}/.cache/irix/current-wallpaper"; # Or "/path/to/image.png"
              color = "rgba(17, 17, 17, 1.0)"; # Fallback

              # Blur settings (Hyprland style)
              blur_passes = 3;
              blur_size = 7;
              noise = 0.0117;
              contrast = 0.8916;
              brightness = 0.8172;
              vibrancy = 0.1696;
              vibrancy_darkness = 0.05;

              # Reloading (Ignored if path is "screenshot")
              reload_time = -1;
              reload_cmd = "";
              crossfade_time = -1.0;
              zindex = -1;
            }
          ];

          # -----------------------------------------------------
          # 3. INPUT FIELD WIDGET (List)
          # -----------------------------------------------------
          input-field = [
            {
              monitor = "";
              size = "250, 60";
              position = "0, -120";
              halign = "center";
              valign = "center";
              zindex = 0;

              # Styling
              outline_thickness = 2;
              rounding = -1; # -1 means complete rounding (circle/oval)
              outer_color = "rgba(255, 255, 255, 0.2)";
              inner_color = "rgba(0, 0, 0, 0.4)";
              font_color = "rgb(200, 200, 200)";
              font_family = "JetBrains Mono Nerd Font";

              # Placeholder & Text
              placeholder_text = ''<i><span foreground="##ffffff99">Input Password...</span></i>'';
              fade_on_empty = true;
              fade_timeout = 2000; # milliseconds
              hide_input = false; # Set true to show swaylock-style ring instead of text

              # Password Dots
              dots_size = 0.25;
              dots_spacing = 0.15;
              dots_center = true;
              dots_rounding = -1;

              # Authentication States
              check_color = "rgba(204, 136, 34, 1.0)"; # Orange while checking
              fail_color = "rgba(204, 34, 34, 1.0)"; # Red on fail
              fail_text = ''<i>$FAIL <b>($ATTEMPTS)</b></i>'';
              fail_timeout = 2000;
              fail_transition = 300;

              # Shadows
              shadow_passes = 0;
              shadow_size = 3;
              shadow_color = "rgba(0, 0, 0, 1.0)";
              shadow_boost = 1.2;
            }
          ];

          # -----------------------------------------------------
          # 4. LABEL WIDGETS (List)
          # -----------------------------------------------------
          label = [
            # Clock Label
            {
              monitor = "";
              text = "$TIME";
              text_align = "center";
              color = "rgba(255, 255, 255, 1.0)";
              font_size = 75;
              font_family = "JetBrains Mono Nerd Font ExtraBold";
              rotate = 0; # Degrees counter-clockwise
              position = "0, 80";
              halign = "center";
              valign = "center";
              zindex = 0;

              shadow_passes = 2;
              shadow_size = 4;
            }
            # Greeting Label
            {
              monitor = "";
              text = "Welcome back, $USER";
              color = "rgba(200, 200, 200, 0.8)";
              font_size = 20;
              font_family = "JetBrains Mono Nerd Font";
              position = "0, 0";
              halign = "center";
              valign = "center";
            }
          ];

          # -----------------------------------------------------
          # 5. IMAGE WIDGET (List) -> Profile Picture
          # -----------------------------------------------------
          image = [
            {
              monitor = "edP-1"; # Show only on laptop display
              path = "/home/${user}/.cache/irix/current-wallpaper"; # Nix relative path
              size = 150; # Lesser side if not 1:1 ratio
              rounding = -1; # -1 means circle
              border_size = 4;
              border_color = "rgba(221, 221, 221, 1.0)";
              rotate = 0;

              position = "0, 200";
              halign = "center";
              valign = "center";
              zindex = 0;

              # Dynamic reloading (e.g., for currently playing album art)
              reload_time = -1;
              reload_cmd = "";

              shadow_passes = 1;
              shadow_size = 5;
            }
          ];

          # -----------------------------------------------------
          # 6. SHAPE WIDGET (List) -> Geometric decorations
          # -----------------------------------------------------
          shape = [
            {
              monitor = "";
              size = "360, 60"; # Width, Height
              color = "rgba(17, 17, 17, 0.5)";
              rounding = -1; # -1 for circle/pill
              rotate = 0;
              border_size = 2;
              border_color = "rgba(0, 207, 230, 1.0)";

              xray = false; # If true, makes a literal "hole" in the background

              position = "0, 80";
              halign = "center";
              valign = "center";
              zindex = -1; # Placed behind the label

              shadow_passes = 0;
            }
          ];
        };
      };
    };
  };
}
