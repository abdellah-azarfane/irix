{
      flake.nixosModules.noctalia-bar = { config, lib, ... }: {

        irix.apps.noctalia.files."config.toml" = {
          # [bar] Configuration
          bar = {
            order = ["main"];             # layer-shell creation order

            # [bar.main]
            main = {
              position = "top";           # top | bottom | left | right
              enabled = true;
              auto_hide = false;          # slide out after pointer leaves; reveal from edge trigger strip
              reserve_space = true;       # reserve compositor exclusive zone / push windows away

              thickness = 34;             # bar cross-axis size in pixels (height for horizontal, width for vertical)
              background_opacity = 1.0;   # 0.0 (transparent) to 1.0 (opaque)
              shadow = true;              # cast the global [shell.shadow]
              contact_shadow = false;     # dark gradient between an attached panel and the bar (depth at the seam)
              attach_panels = true;       # allow panels to attach to this bar (false = always float)
              radius = 12;                # global corner radius fallback
              radius_top_left = 12;
              radius_top_right = 12;
              radius_bottom_left = 12;
              radius_bottom_right = 12;
              margin_ends = 180;          # inset from each end of the bar along its main axis
              margin_edge = 10;           # distance from the nearest screen edge (positive values float the bar)
              padding = 14;               # main-axis padding from bar edges to start/end widget sections
              widget_spacing = 6;         # gap between widgets within a section
              scale = 1.0;                # content scale multiplier for icons and text

              # Default capsule style for all widgets on this bar (see Widget Capsule section)
              capsule = true;             # (merged from later snippet)
              capsule_groups = ["status" "media"];
              capsule_fill = "surface_variant";
              capsule_radius = 8.0;       # omit for automatic pill radius
              capsule_opacity = 0.9;
              capsule_border = "outline"; # omit this key for no border by default

              start = ["launcher" "wallpaper" "workspaces"];
              center = ["clock"];

              # We use the end layout that includes the custom clock-seconds from your snippet
              end = ["media" "tray" "notifications" "clipboard" "network" "bluetooth" "volume" "brightness" "battery" "control-center" "session" "clock-seconds"];

              # [bar.main.monitor.dp1]
              monitor.dp1 = {
                match = "DP-1";           # connector name or description substring
                enabled = true;
                thickness = 44;
                background_opacity = 0.9;
                radius = 0;
                radius_top_left = 12;
                radius_top_right = 12;
                radius_bottom_left = 0;
                radius_bottom_right = 0;
                padding = 20;
                widget_spacing = 6;
                start = [];
                center = ["workspaces"];
                end = ["volume" "clock"];
              };
            };

            # [bar.accent] (Accent bar: primary fill + matching text)
            accent = {
              capsule = true;
              capsule_fill = "primary";
              capsule_foreground = "on_primary";
              capsule_padding = 10;
              capsule_radius = 8.0;
            };
      };
     };
  };
}
