{
  flake.nixosModules.noctalia-desktop-widgets = { config, lib, ... }: {

    irix.apps.noctalia.files."desktop-widgets.toml" = {

      # [desktop_widgets] Configuration

      desktop_widgets = {
        enabled = true;
        schema_version = 1;
      };

      # [grid] Configuration

      grid = {
        visible = true;
        cell_size = 16;
        major_interval = 4;
      };


      # [[widget]] Array (Desktop Widgets)
      # In Nix, TOML double brackets `[[widget]]` become a list `[` containing sets `{ }`.
      widget = [

        #  Clock Widget
        {
          id = "desktop-widget-0000000000000001";
          type = "clock";
          output = "DP-1";
          cx = 960.0;
          cy = 540.0;
          scale = 1.5;
          rotation = 0.0;
          # enabled = false; # Uncomment to hide, but preserve in the file

          settings = {
            format = "{:%H:%M}";
            color = "on_surface";
            shadow = true;
            background = true;
            background_color = "surface";
          };
        }

        #  Audio Visualizer Widget
        {
          id = "desktop-widget-0000000000000002";
          type = "audio_visualizer";
          output = "DP-1";
          cx = 1040.0;
          cy = 620.0;
          scale = 1.25;
          rotation = 0.0;

          settings = {
            bands = 32;
            aspect_ratio = 2.5;
            mirrored = true;
            low_color = "primary";
            high_color = "secondary";
          };
        }

        #  Weather Widget
        {
          id = "desktop-widget-0000000000000003";
          type = "weather";
          output = "DP-1";
          cx = 320.0;
          cy = 200.0;
          scale = 1.0;
          rotation = 0.0;

          settings = {
            color = "on_surface";
            shadow = true;
          };
        }

        #  Media Player Widget
        {
          id = "desktop-widget-0000000000000004";
          type = "media_player";
          output = "DP-1";
          cx = 500.0;
          cy = 700.0;
          scale = 1.5;
          rotation = 0.0;

          settings = {
            layout = "horizontal";
            color = "on_surface";
            shadow = true;
          };
        }

        #  Sticker Widget
        {
          id = "desktop-widget-0000000000000005";
          type = "sticker";
          output = "DP-1";
          cx = 800.0;
          cy = 400.0;
          scale = 1.0;
          rotation = 0.0;

          settings = {
            image_path = "/path/to/image.png";
            opacity = 1.0;
          };
        }

        #  System Monitor (Sysmon) Widget
        {
          id = "desktop-widget-0000000000000006";
          type = "sysmon";
          output = "DP-1";
          cx = 200.0;
          cy = 800.0;
          scale = 1.0;
          rotation = 0.0;

          settings = {
            stat = "cpu_usage";
            stat2 = "cpu_temp";
            color = "primary";
            color2 = "secondary";
            show_label = true;
            shadow = true;
            background = true;
          };
        }

      ];

    };
  };
}
