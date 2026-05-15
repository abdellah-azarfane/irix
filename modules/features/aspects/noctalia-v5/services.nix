{
  flake.nixosModules.noctalia-services = { config, lib, ... }: {

    irix.apps.noctalia.files."config.toml" = {

      # [audio] Configuration
      audio = {
        enable_overdrive = false;  # allow volume sliders above 100% (up to 150%)
        enable_sounds = false;     # master toggle for UI sounds
        sound_volume = 0.5;        # global sound volume (0.0 - 1.0)
        volume_change_sound = "";  # empty = bundled default sounds/volume-change.wav
        notification_sound = "";   # empty = bundled default sounds/notification.wav
      };

      # [brightness] Configuration
      brightness = {
        enable_ddcutil = false;
        ignore_mmids = [ ];        # e.g. ["ACI-ROG_PG279Q-10220"] — skip in all ddcutil commands

        monitor = {
          "eDP-1".backend = "backlight"; # auto | none | backlight | ddcutil
          "DP-1".backend = "ddcutil";
        };
      };

      # [nightlight] Configuration
      nightlight = {
        enabled = false;
        force = false;               # force night mode from startup
        use_weather_location = true; # prefer weather coordinates; requires weather auto_locate or address

        temperature_day = 6500;      # Kelvin (must be > temperature_night by at least 100)
        temperature_night = 4000;    # Kelvin

        # Option A: explicit schedule (used when weather location is off or unavailable)
        start_time = "20:30";        # HH:MM — sunset / night starts
        stop_time = "07:30";         # HH:MM — sunrise / day starts

        # Option B: manual geolocation schedule (fallback when start/stop are missing)
        # latitude = 52.5200;
        # longitude = 13.4050;
      };

      # ==========================================
      # [system.monitor] Configuration
      # ==========================================
      system.monitor = {
        enabled = true; # sample CPU, memory, network, load, temperature, GPU VRAM, and disk statistics
      };

      # [weather] Configuration
      weather = {
        enabled = true;
        auto_locate = true;          # resolve coordinates from IP address when true
        address = "";      # geocoded when auto_locate = false
        refresh_minutes = 30;
        unit = "metric";              # metric | imperial
      };

      # [idle] Configuration
      idle = {
        # Seconds to fade a fullscreen surface-tint overlay, then run the idle command.
        # 0 disables the overlay (the command runs as soon as the compositor reports idle).
        # Parsed between 0 and 120; the in-app Settings stepper uses whole seconds 0–30.
        pre_action_fade_seconds = 2.0;

        behavior = {
          lock = {
            timeout = 600;
            command = "noctalia:screen-lock";
            enabled = false;          # explicitly disabled in the default config
          };

          "screen-off" = {
            timeout = 660;
            command = "noctalia:dpms-off";
            resume_command = "noctalia:dpms-on";
            enabled = false;          # explicitly disabled in the default config
          };

          custom = {
            timeout = 48;
            command = "notify-send 'Idle' 'Going idle'";
            resume_command = "notify-send 'Idle' 'Back from idle'";
          };
        };
      };


      # [notification] Configuration
      notification = {
        enable_daemon = true;         # when false, don't claim org.freedesktop.Notifications; internal toasts still work
        position = "top_right";       # top_right | top_left | top_center | bottom_right | bottom_left | bottom_center
        layer = "top";                # top | overlay
        background_opacity = 0.97;    # toast card background alpha; lower values let compositor blur show through
        monitors = [ ];               # empty = all displays; otherwise connector/description selectors (e.g. ["eDP-1", "DP-1"])
      };

    };
  };
}
