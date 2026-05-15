{
  flake.nixosModules.noctalia-dock = { config, lib, ... }: {
    irix.apps.noctalia.files."config.toml" = {

      # ==========================================
      # [dock] Configuration
      # ==========================================
      dock = {
        enabled = false;                # set true to activate
        position = "bottom";            # top | bottom | left | right
        active_monitor_only = false;    # when true, only show apps/windows from the active monitor

        icon_size = 48;
        padding = 8;                    # inner padding around the icon row (all sides)
        item_spacing = 6;               # gap between items in pixels
        background_opacity = 0.88;
        shadow = true;                  # cast the global [shell.shadow]
        radius = 16;
        radius_top_left = 16;           # optional per-corner overrides
        radius_top_right = 16;
        radius_bottom_left = 16;
        radius_bottom_right = 16;
        margin_ends = 0;                # inset from each end of the dock along its main axis
        margin_edge = 8;                # distance from the nearest screen edge (positive values float the dock)

        show_running = true;            # also show running apps not in the pinned list
        auto_hide = false;              # fade out when pointer leaves; fade in on approach
        reserve_space = false;          # keep exclusive zone even when auto-hidden

        active_scale = 1.0;             # icon scale for the focused app (clamped 0.1–1.75)
        inactive_scale = 0.85;          # icon scale for non-focused apps (clamped 0.1–1.0)
        active_opacity = 1.0;
        inactive_opacity = 0.85;
        show_instance_count = true;     # badge with window count when an app has 2+ windows

        # Desktop entry IDs, StartupWMClass, or human-readable names
        pinned = [ "helium" "zeditor" "kitty" ];
      };
    };
  };
}
