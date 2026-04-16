{ self, inputs, ... }:
{
  flake.nixosModules.yazi = { pkgs, lib, config, ... }:
  let
  user = config.preferences.user.name;
  pluginLuaFiles = builtins.readDir ../plugins;

  readLuaFile = name: builtins.readFile (../plugins + "/${name}");

  initLua = lib.concatStringsSep "\n\n" (
    lib.filter (s: s != "") (
      lib.mapAttrsToList (
        name: type: if type == "regular" && lib.hasSuffix ".lua" name then readLuaFile name else ""
      ) pluginLuaFiles
    )
  );

  markdownPreviewScript = pkgs.writeShellScript "yazi-markdown-preview" ''
    #!${pkgs.runtimeShell}
    if ! command -v pandoc >/dev/null 2>&1; then
      echo "Preview Error: 'pandoc' command not found in wrapper environment." >&2
      exit 1
    fi
    if ! command -v w3m >/dev/null 2>&1; then
      echo "Preview Error: 'w3m' command not found in wrapper environment." >&2
      exit 1
    fi

    file_path="$1"
    width="''${YACOL:-80}"
    (${pkgs.pandoc}/bin/pandoc -f markdown -t html --standalone "$file_path" 2>&1 | ${pkgs.w3m}/bin/w3m -T text/html -dump -cols "$width")
    exit $?
  '';

  xdgFiles = {
    "yazi/plugins/markdown.sh" = {
      source = markdownPreviewScript;
      executable = true;
    };

    "glow/gruvbox.json".text = builtins.toJSON {
      document = {
        block_prefix = "\n";
        block_suffix = "\n";
        color = "#C5C9C7";
        margin = 2;
      };
      block_quote = {
        indent = 1;
        indent_token = "│ ";
        color = "#6B7E84";
      };
      paragraph = { };
      list = {
        level_indent = 2;
      };
      heading = {
        block_suffix = "\n";
        color = "#C5C9C7";
        bold = true;
      };
      h1 = {
        prefix = "# ";
        color = "#C5C9C7";
        bold = true;
      };
      h2 = {
        prefix = "## ";
        color = "#C5C9C7";
        bold = true;
      };
      h3 = {
        prefix = "### ";
        color = "#A4A7A4";
        bold = true;
      };
      h4 = {
        prefix = "#### ";
        color = "#A4A7A4";
      };
      h5 = {
        prefix = "##### ";
        color = "#8EA4A2";
      };
      h6 = {
        prefix = "###### ";
        color = "#6B7E84";
        bold = false;
      };
      text = { };
      strikethrough = {
        crossed_out = true;
      };
      emph = {
        italic = true;
        color = "#8EA4A2";
      };
      strong = {
        bold = true;
        color = "#C5C9C7";
      };
      hr = {
        color = "#22262D";
        format = "\n────────\n";
      };
      item = {
        block_prefix = "• ";
      };
      enumeration = {
        block_prefix = ". ";
      };
      task = {
        ticked = "[✓] ";
        unticked = "[ ] ";
      };
      link = {
        color = "#8BA4B0";
        underline = true;
      };
      link_text = {
        color = "#7AA89F";
        bold = true;
      };
      image = {
        color = "#938AA9";
        underline = true;
      };
      image_text = {
        color = "#6B7E84";
        format = "Image: {{.text}} →";
      };
      code = {
        prefix = " ";
        suffix = " ";
        color = "#87A987";
        background_color = "#0f1316";
      };
      code_block = {
        color = "#C5C9C7";
        margin = 2;
        chroma = {
          text = {
            color = "#C5C9C7";
          };
          error = {
            color = "#C5C9C7";
            background_color = "#E46876";
          };
          comment = {
            color = "#6B7E84";
          };
          comment_preproc = {
            color = "#7AA89F";
          };
          keyword = {
            color = "#C5C9C7";
          };
        };
      };
    };
  };

  # --- Settings ---
  settings = {
    # --- General ---
    input = {
      cd_offset = [ 0 2 50 3 ];
      cd_origin = "top-center";
      cd_title = "Change directory:";
      create_offset = [ 0 2 50 3 ];
      create_origin = "top-center";
      create_title = [ "Create:" "Create:" ];
      cursor_blink = false;
      delete_offset = [ 0 2 50 3 ];
      delete_origin = "top-center";
      delete_title = "Delete {n} selected file{s} permanently? (y/N)";
      filter_offset = [ 0 2 50 3 ];
      filter_origin = "top-center";
      filter_title = "Filter:";
      find_offset = [ 0 2 50 3 ];
      find_origin = "top-center";
      find_title = [ "Find next:" "Find previous:" ];
      overwrite_offset = [ 0 2 50 3 ];
      overwrite_origin = "top-center";
      overwrite_title = "Overwrite an existing file? (y/N)";
      quit_offset = [ 0 2 50 3 ];
      quit_origin = "top-center";
      quit_title = "{n} task{s} running, sure to quit? (y/N)";
      rename_offset = [ 0 1 50 3 ];
      rename_origin = "hovered";
      rename_title = "Rename:";
      search_offset = [ 0 2 50 3 ];
      search_origin = "top-center";
      search_title = "Search via {n}:";
      shell_offset = [ 0 2 50 3 ];
      shell_origin = "top-center";
      shell_title = [ "Shell:" "Shell (block):" ];
      trash_offset = [ 0 2 50 3 ];
      trash_origin = "top-center";
      trash_title = "Move {n} selected file{s} to trash? (y/N)";
    };

    mgr = {
      linemode = "size";
      mouse_events = [ "click" "scroll" "touch" "move" "drag" ];
      ratio = [ 1 4 3 ];
      scrolloff = 5;
      show_hidden = false;
      show_symlink = true;
      sort_by = "alphabetical";
      sort_dir_first = true;
      sort_reverse = false;
      sort_sensitive = false;
      sort_translit = false;
    };

    select = {
      open_offset = [ 0 1 50 7 ];
      open_origin = "hovered";
      open_title = "Open with:";
    };

    preview = {
      cache_dir = "\$XDG_CACHE_HOME/yazi";
      image_filter = "nearest";
      image_quality = 70;
      max_width = 2000;
      sixel_fraction = 15;
      tab_size = 2;
      ueberzug_offset = [ 0 0 0 0 ];
      ueberzug_scale = 1;
      image_delay = 20;
    };

    tasks = {
      bizarre_retry = 5;
      image_alloc = 536870912;
      image_bound = [ 0 0 ];
      macro_workers = 25;
      micro_workers = 10;
      suppress_preload = false;
    };

    which = {
      sort_by = "none";
      sort_reverse = false;
      sort_sensitive = false;
      sort_translit = false;
    };

    log = {
      enabled = false;
    };

    opener = {
      edit = [
        {
          desc = "Edit with Neovim";
          for = "unix";
          block = true;
          run = "nvim \"$@\"";
        }
      ];

      edit-helix = [
        {
          desc = "Edit with Helix";
          for = "unix";
          block = true;
          run = "hx \"$@\"";
        }
      ];

      edit-zed = [
        {
          desc = "Edit with Zed";
          for = "unix";
          block = true;
          run = "zeditor \"$@\"";
        }
      ];

      edit-nano = [
        {
          desc = "Edit with Nano";
          for = "unix";
          block = true;
          run = "nano \"$@\"";
        }
      ];

      edit-emacs = [
        {
          desc = "Edit with Emacs";
          for = "unix";
          block = true;
          run = "emacs \"$@\"";
        }
      ];

      browser-personal = [
        {
          desc = "Firefox (Personal)";
          for = "unix";
          run = "firefox -p Personal -new-window \"$@\"";
        }
      ];

      browser-work = [
        {
          desc = "Firefox (SolenoidLabs)";
          for = "unix";
          run = "firefox -p SolenoidLabs -new-window \"$@\"";
        }
      ];

      browser-incognito = [
        {
          desc = "Firefox (Private)";
          for = "unix";
          run = "firefox -p Personal --private-window \"$@\"";
        }
      ];

      libreoffice-calc = [
        {
          desc = "LibreOffice Calc (Spreadsheets)";
          for = "unix";
          orphan = true;
          run = "libreoffice --calc \"$@\"";
        }
      ];
    };

    open = {
      rules = [
        {
          mime = "text/*";
          use = [ "edit" ];
        }
        {
          name = "*.nix";
          use = [ "edit" ];
        }
        {
          name = "*.lua";
          use = [ "edit" ];
        }
        {
          name = "*.md";
          use = [ "edit" ];
        }
        {
          name = "*.toml";
          use = [ "edit" ];
        }
        {
          name = "*.json";
          use = [ "edit" ];
        }
        {
          name = "*.yaml";
          use = [ "edit" ];
        }
        {
          name = "*.yml";
          use = [ "edit" ];
        }
        {
          name = "*.conf";
          use = [ "edit" ];
        }
      ];
    };
  };

  # --- Keymap ---
  keymap = {
    mgr.prepend_keymap = [
      {
        on = [ "f" "f" ];
        run = "plugin fg -- fzf";
        desc = "Search files by name (fg)";
      }
      {
        on = [ "f" "g" ];
        run = "plugin fr rg";
        desc = "Search files by content using rg + fzf (fr)";
      }
      {
        on = [ "f" "G" ];
        run = "plugin fr rga";
        desc = "Search files by content using rga + fzf (fr)";
      }
      {
        on = [ "g" "r" ];
        run = "cd $IRIX";
        desc = "Go to irix";
      }
      {
        on = [ "g" "h" ];
        run = "cd $HOME";
        desc = "Go to user home";
      }
      {
        on = [ "g" "H" ];
        run = "cd $XDG_CACHE_HOME";
        desc = "Go to .cache";
      }
      {
        on = [ "g" "b" ];
        run = "cd $XDG_BIN_HOME";
        desc = "Go to ./local/bin";
      }
      {
        on = [ "g" "e" ];
        run = "cd $DOTCONFIG_DOOM";
        desc = "Go to ./config/doom";
      }
      {
        on = [ "g" "u" ];
        run = "cd $DEV_UTILS";
        desc = "Go to dev/utils";
      }
      {
        on = [ "g" "p" ];
        run = ''shell -- ya emit cd "$(git rev-parse --show-toplevel)"'';
        desc = "Go to Project Root";
      }
      {
        on = [ "g" "A" ];
        run = "cd $HOME/.local/share/applications/";
        desc = "Go to .local/share/applications";
      }
      {
        on = [ "g" "d" ];
        run = "cd $HOME_DOWNLOADS";
        desc = "Go to downloads";
      }

      {
        on = [ "F" ];
        run = "plugin smart-filter";
        desc = "Smart Filter";
      }
      {
        on = [ "l" ];
        run = "open";
        desc = "Open hovered file/dir";
      }
      {
        on = [ "<Enter>" ];
        run = "open";
        desc = "Open hovered file/dir";
      }
      {
        on = [ ";" ];
        run = "plugin jump-to-char";
        desc = "Jump to char (like vim f)";
      }
      {
        on = [ "r" "r" ];
        run = "rename --cursor=before_ext";
        desc = "Rename selected file(s)";
      }
      {
        on = [ "r" "a" ];
        run = "rename --empty=all --cursor=start";
        desc = "Rename clear selected file(s)";
      }
      {
        on = [ "r" "c" ];
        run = "rename --empty=stem --cursor=start";
        desc = "Rename change selected file(s)";
      }
      {
        on = [ "H" ];
        run = "plugin duckdb -1";
        desc = "DuckDB: scroll columns left";
      }
      {
        on = [ "L" ];
        run = "plugin duckdb +1";
        desc = "DuckDB: scroll columns right";
      }
      {
        on = [ "<C-d>" ];
        run = "plugin duckdb --toggle-mode";
        desc = "DuckDB: toggle summary/standard mode";
      }
      {
        on = [ "g" "i" ];
        run = "plugin lazygit";
        desc = "Open LazyGit";
      }
      {
        on = [ "g" "D" ];
        run = "plugin diff";
        desc = "Diff selected files";
      }
      {
        on = [ "<C-g>" ];
        run = ''shell -- dragon -x -i -T "$@"'';
        desc = "Drag files to other apps";
      }
      {
        on = [ "<A-g>" ];
        run = ''shell -- dragon -x -i -T -a'';
        desc = "Drag all selected files";
      }
      {
        on = [ "Y" ];
        run = "plugin wl-clipboard";
        desc = "Copy files to system clipboard (Wayland)";
      }
      {
        on = [ "c" "a" ];
        run = "plugin compress";
        desc = "Compress selected files";
      }
      {
        on = [ "c" "x" ];
        run = "plugin ouch --extract";
        desc = "Extract archive here";
      }
      {
        on = [ "T" ];
        run = "plugin toggle-pane --max-preview";
        desc = "Maximize preview pane";
      }
      {
        on = [ "<C-t>" ];
        run = "plugin toggle-pane --min-preview";
        desc = "Minimize preview pane";
      }
      {
        on = [ "c" "m" ];
        run = "plugin chmod";
        desc = "Change file permissions";
      }
      {
        on = [ "c" "s" ];
        run = "plugin sudo";
        desc = "Execute with sudo";
      }
      {
        on = [ "m" "m" ];
        run = "plugin mount";
        desc = "Mount/unmount disk";
      }
      {
        on = [ "M" ];
        run = "plugin mediainfo";
        desc = "Show media info";
      }
      {
        on = [ "p" ];
        run = "paste";
        desc = "Paste files";
      }
      {
        on = [ "P" "s" ];
        run = "plugin projects --save";
        desc = "Save current as project";
      }
      {
        on = [ "P" "l" ];
        run = "plugin projects --load";
        desc = "Load project";
      }
      {
        on = [ "P" "d" ];
        run = "plugin projects --delete";
        desc = "Delete project";
      }
      {
        on = [ "P" "D" ];
        run = "plugin projects --delete-all";
        desc = "Delete all projects";
      }
      {
        on = [ "P" "m" ];
        run = "plugin projects --merge";
        desc = "Merge with other projects";
      }
      {
        on = [ "u" "r" ];
        run = "plugin restore";
        desc = "Restore deleted files";
      }
      {
        on = [ "1" ];
        run = "tab_switch 0";
        desc = "Switch to tab 1";
      }
      {
        on = [ "2" ];
        run = "tab_switch 1";
        desc = "Switch to tab 2";
      }
    ];
  };

  # --- Theme ---
  theme = {
    icon = {
      prepend_globs = [
        { url = "*/*.ix/"; text = "󰊕"; fg = "#fb4934"; }
      ];
      prepend_files = [
        { name = "justfile"; text = "󱓞"; fg = "#665c54"; }
        { name = ".env.example"; text = ""; fg = "#665c54"; }
      ];
      prepend_dirs = [
        { name = "irix"; text = "λ"; fg = "#fb4934"; }
        { name = "*.ix"; text = "󰊕"; fg = "#fb4934"; }
        { name = "kronos"; text = "󰏉"; fg = "#fb4934"; }
        { name = "personal-website"; text = "ψ"; fg = "#fb4934"; }
        { name = "downloads"; text = ""; fg = "#7daea3"; }
        { name = "pendings"; text = ""; fg = "#7daea3"; }
        { name = "pictures"; text = "󰄄"; fg = "#7daea3"; }
        { name = "professional"; text = ""; fg = "#7daea3"; }
        { name = "solenoid-labs"; text = "󱒀"; fg = "#7daea3"; }
        { name = "dev"; text = ""; fg = "#7daea3"; }
        { name = "vaults"; text = "󰴓"; fg = "#7daea3"; }
        { name = "academic"; text = "󰂺"; fg = "#7daea3"; }
        { name = "documents"; text = "󰈙"; fg = "#7daea3"; }
        { name = ".config"; text = ""; fg = "#7daea3"; }
        { name = ".local"; text = ""; fg = "#7daea3"; }
      ];
      prepend_exts = [
        { name = "j2"; text = ""; fg = "#ebdbb2"; }
        { name = "jinja"; text = ""; fg = "#ebdbb2"; }
        { name = "jinja2"; text = ""; fg = "#ebdbb2"; }
        { name = "yuck"; text = "󰒓"; fg = "#665c54"; }
        { name = "backup"; text = "󰒓"; fg = "#665c54"; }
        { name = "bkp"; text = "󰒓"; fg = "#665c54"; }
        { name = "bak"; text = "󰒓"; fg = "#665c54"; }
        { name = "cabal"; text = ""; fg = "#e089a1"; }
        { name = "rh"; text = "󰘧"; fg = "#fb4934"; }
        { name = "txt"; text = "󰈙"; fg = "#d5c4a1"; }
        { name = "rtf"; text = "󰈙"; fg = "#d5c4a1"; }
        { name = "rst"; text = "󰈙"; fg = "#d5c4a1"; }
        { name = "g"; text = "󰿉"; fg = "#ebdbb2"; }
        { name = "cl"; text = ""; fg = "#ebdbb2"; }
        { name = "idr"; text = "󰊕"; fg = "#ebdbb2"; }
        { name = "nb"; text = "󱂅"; fg = "#ebdbb2"; }
        { name = "thy"; text = "󰬛"; fg = "#ebdbb2"; }
        { name = "glsl"; text = ""; fg = "#ebdbb2"; }
        { name = "hlsl"; text = ""; fg = "#ebdbb2"; }
        { name = "metal"; text = ""; fg = "#ebdbb2"; }
        { name = "wgsl"; text = ""; fg = "#ebdbb2"; }
        { name = "cir"; text = ""; fg = "#ebdbb2"; }
        { name = "chpl"; text = "󰬊"; fg = "#ebdbb2"; }
        { name = "stan"; text = ""; fg = "#ebdbb2"; }
        { name = "sage"; text = "󰬚"; fg = "#ebdbb2"; }
        { name = "mac"; text = "󰬔"; fg = "#ebdbb2"; }
      ];
    };
    };
  in {
    home-manager.users.${user} = {
      programs.yazi = {
      enable = true;
      settings = settings;
      theme = theme;
      keymap = keymap;
      initLua = initLua;
      plugins = {
      # --- Core Functionality ---
      chmod = pkgs.yaziPlugins.chmod;
      diff = pkgs.yaziPlugins.diff;
      sudo = pkgs.yaziPlugins.sudo;
      restore = pkgs.yaziPlugins.restore;

      # --- Navigation & Productivity ---
      smart-filter = pkgs.yaziPlugins.smart-filter;
      smart-paste = pkgs.yaziPlugins.smart-paste;
      jump-to-char = pkgs.yaziPlugins.jump-to-char;
      relative-motions = pkgs.yaziPlugins.relative-motions;
      projects = pkgs.yaziPlugins.projects;

      # --- UI & Visual ---
      full-border = pkgs.yaziPlugins.full-border;
      toggle-pane = pkgs.yaziPlugins.toggle-pane;

      # --- Git Integration ---
      git = pkgs.yaziPlugins.git;
      lazygit = pkgs.yaziPlugins.lazygit;

      # --- File Preview ---
      duckdb = pkgs.yaziPlugins.duckdb;
      miller = pkgs.yaziPlugins.miller;
      glow = pkgs.yaziPlugins.glow;
      piper = pkgs.yaziPlugins.piper;
      mediainfo = pkgs.yaziPlugins.mediainfo;
      rich-preview = pkgs.yaziPlugins.rich-preview;

      # --- Archive & Compression ---
      ouch = pkgs.yaziPlugins.ouch;
      compress = pkgs.yaziPlugins.compress;

      # --- System & Utilities ---
      mount = pkgs.yaziPlugins.mount;
      mime-ext = pkgs.yaziPlugins.mime-ext;

      # --- Clipboard (Wayland) ---
      wl-clipboard = pkgs.yaziPlugins.wl-clipboard;
      };
      };
      xdg.configFile = xdgFiles;
    };
  };
  }
