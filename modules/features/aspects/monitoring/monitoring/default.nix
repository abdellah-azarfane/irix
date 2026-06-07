{
  self,
  ...
}: {
  flake.nixosModules.monitoring = { pkgs, config, ... }:
  let
    user = config.preferences.user.name;
  in {

    imports = [ self.nixosModules.info ];

    home-manager.users.${user} = {

      programs.bottom.enable = true;

      home.packages = with pkgs; [

        # Monitoring
        bottom # Better htop alternative
        btop # Better htop alternative
        mesa-demos # OpenGL & Mesa tools (glxinfo, glxgears, etc.)
        hyperfine # Command-line benchmarking tool
        psmisc # killall, pstree, etc.
        lm_sensors # Tools for reading hardware sensors
        procs # Rustified ps
        lnav # Logfile navigator
        pv # Monitor progress using bars
        ts # Task spooler

        # --- visuals ---
        librsvg # Small library to render SVG images to Cairo surfaces
        ffmpegthumbnailer # For video previews
        ffmpeg-full # For video previews
        imagemagick # Image manipulation toolkit
        mpvpaper # Set videos as wallpapers
        libwebp # Tools for WebP images
        ueberzugpp # Write images on terminal on wayland (kitty, etc)
      ];

      programs.btop = {
      enable = true;
      settings = {
       color_theme = "chiaroscuro";
       theme_background = false;
       truecolor = true;
       force_tty = false;
       presets = "cpu:1:default,proc:0:default cpu:0:default,mem:0:default,net:0:default cpu:0:block,net:0:tty";
       vim_keys = true;
       rounded_corners = false;
       graph_symbol = "braille";
       graph_symbol_cpu = "default";
       graph_symbol_gpu = "default";
       graph_symbol_mem = "default";
       graph_symbol_net = "default";
       graph_symbol_proc = "default";
       shown_boxes = "cpu mem net proc";
       update_ms = 2000;
       proc_sorting = "cpu lazy";
       proc_reversed = false;
       proc_tree = true;
       proc_colors = true;
       proc_gradient = true;
       proc_per_core = true;
       proc_mem_bytes = true;
       proc_cpu_graphs = true;
       proc_info_smaps = true;
       proc_left = false;
       proc_filter_kernel = true;
       proc_aggregate = true;
       cpu_graph_upper = "Auto";
       cpu_graph_lower = "Auto";
       show_gpu_info = "Auto";
       cpu_invert_lower = true;
       cpu_single_graph = false;
       cpu_bottom = false;
       show_uptime = true;
       check_temp = true;
       cpu_sensor = "Auto";
       show_coretemp = true;
       cpu_core_map = "";
       temp_scale = "celsius";
       base_10_sizes = false;
       show_cpu_freq = true;
       clock_format = "%X";
       background_update = true;
       custom_cpu_name = "";
       disks_filter = "";
       mem_graphs = true;
       mem_below_net = false;
       zfs_arc_cached = true;
       show_swap = true;
       swap_disk = true;
       show_disks = true;
       only_physical = true;
       use_fstab = true;
       zfs_hide_datasets = false;
       disk_free_priv = false;
       show_io_stat = true;
       io_mode = false;
       io_graph_combined = false;
       io_graph_speeds = "";
       net_download = 100;
       net_upload = 100;
       net_auto = true;
       net_sync = true;
       net_iface = "";
       show_battery = true;
       selected_battery = "Auto";
       show_battery_watts = true;
       log_level = "WARNING";
       nvml_measure_pcie_speeds = true;
       gpu_mirror_graph = true;
       custom_gpu_name0 = "";
       custom_gpu_name1 = "";
       custom_gpu_name2 = "";
       custom_gpu_name3 = "";
       custom_gpu_name4 = "";
       custom_gpu_name5 = "";
     };
      themes = {
         chiaroscuro = ''
          # Main background, empty for terminal default, need to be empty if you want transparent background
          theme[main_bg]="#090E13"

          # Main text color
          theme[main_fg]="#C5C9C7"

          # Title color for boxes
          theme[title]="#C5C9C7"

          # Highlight color for keyboard shortcuts
          theme[hi_fg]="#7FB4CA"

          # Background color of selected item in processes box
          theme[selected_bg]="#393B44"

          # Foreground color of selected item in processes box
          theme[selected_fg]="#7FB4CA"

          # Color of inactive/disabled text
          theme[inactive_fg]="#717C7C"

          # Color of text appearing on top of graphs, i.e uptime and current network graph scaling
          theme[graph_text]="#C5C9C7"

          # Background color of the percentage meters
          theme[meter_bg]="#22262D"

          # Misc colors for processes box including mini cpu graphs, details memory graph and details status text
          theme[proc_misc]="#C5C9C7"

          # CPU, Memory, Network, Proc box outline colors
          theme[cpu_box]="#938AA9"
          theme[mem_box]="#98BB6C"
          theme[net_box]="#E46876"
          theme[proc_box]="#7FB4CA"

          # Box divider line and small boxes line color
          theme[div_line]="#393B44"

          # Temperature graph color
          theme[temp_start]="#98BB6C"
          theme[temp_mid]="#E6C384"
          theme[temp_end]="#E46876"

          # CPU graph colors
          theme[cpu_start]="#7AA89F"
          theme[cpu_mid]="#7FB4CA"
          theme[cpu_end]="#938AA9"

          # Mem/Disk free meter
          theme[available_start]="#fab387"
          theme[available_mid]="#eba0ac"
          theme[available_end]="#f38ba8"

          # Mem/Disk cached meter
          theme[cached_start]="#7FB4CA"
          theme[cached_mid]="#7AA89F"
          theme[cached_end]="#6A9589"

          # Mem/Disk available meter
          theme[available_start]="#fab387"
          theme[available_mid]="#eba0ac"
          theme[available_end]="#f38ba8"

          # Mem/Disk used meter
          theme[used_start]="#98BB6C"
          theme[used_mid]="#7AA89F"
          theme[used_end]="#6A9589"

          # Download graph colrs
          theme[download_start]="#fab387"
          theme[download_mid]="#eba0ac"
          theme[download_end]="#f38ba8"

          # Upload graph colors
          theme[upload_start]="#a6e3a1"
          theme[upload_mid]="#94e2d5"
          theme[upload_end]="#89dceb"

          # Process box color gradient for threads, mem and cpu usage
          theme[process_start]="#7FB4CA"
          theme[process_mid]="#938AA9"
          theme[process_end]="#717C7C"
        '';
       };
     };
    };
  };
 }
