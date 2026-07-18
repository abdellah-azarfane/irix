{ self, inputs, ... }:
{
  flake.nixosModules.yazi =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
      user = config.preferences.user.name;
    in
    {
      irix.apps.yazi = {
        enable = true;
        homeConfigDir = "yazi";

        # Passing the package here handles the installation automatically
        package = pkgs.yazi;

        files = {
          # Main settings
          "yazi.toml" = {
            manager = {
              ratio = [
                1
                4
                3
              ];
              sort_by = "alphabetical";
              sort_sensitive = false;
              sort_reverse = false;
              sort_dir_first = true;
              linemode = "size";
              show_hidden = false;
              show_symlink = true;
            };
            preview = {
              tab_size = 2;
              max_width = 600;
              max_height = 900;
              cache_dir = "";
              image_filter = "triangle";
              image_quality = 75;
              sixel_fraction = 15;
              ueberzug_scale = 1;
              ueberzug_offset = [
                0
                0
                0
                0
              ];
            };
            # Application definitions
            opener = {
              edit = [
                {
                  run = "emacsclient -c \"$@\"";
                  block = false;
                  desc = "Emacs";
                  for = "unix";
                }
              ];
              image = [
                {
                  run = "imv \"$@\"";
                  block = false;
                  desc = "imv";
                  for = "unix";
                }
              ];
              video = [
                {
                  run = "mpv \"$@\"";
                  block = false;
                  desc = "mpv";
                  for = "unix";
                }
              ];
              audio = [
                {
                  run = "mpv \"$@\"";
                  block = false;
                  desc = "mpv";
                  for = "unix";
                }
              ];
              pdf = [
                {
                  run = "zathura \"$@\"";
                  block = false;
                  desc = "Zathura";
                  for = "unix";
                }
              ];
              office = [
                {
                  run = "onlyoffice-desktopeditors \"$@\"";
                  block = false;
                  desc = "OnlyOffice";
                  for = "unix";
                }
              ];
              libre = [
                {
                  run = "libreoffice \"$@\"";
                  block = false;
                  desc = "LibreOffice";
                  for = "unix";
                }
              ];
              browser = [
                {
                  run = "librewolf \"$@\"";
                  block = false;
                  desc = "Librewolf";
                  for = "unix";
                }
              ];
            };

            # File mapping rules
            open = {
              # Using a list of attribute sets maps directly to TOML's array of tables: [[open.rules]]
              rules = [
                # Microsoft Office formats
                {
                  name = "*.{docx,doc,xlsx,xls,pptx,ppt}";
                  use = "office";
                }
                # Other document formats (ODT, ODS, etc.)
                {
                  mime = "application/vnd.oasis.opendocument.*";
                  use = "libre";
                }
                # PDFs
                {
                  mime = "application/pdf";
                  use = "pdf";
                }
                # Images
                {
                  mime = "image/*";
                  use = "image";
                }
                # Video
                {
                  mime = "video/*";
                  use = "video";
                }
                # Audio
                {
                  mime = "audio/*";
                  use = "audio";
                }
                # Web
                {
                  mime = "text/html";
                  use = "browser";
                }
                # Default to Emacs for text and catch-all
                {
                  mime = "text/*";
                  use = "edit";
                }
                {
                  mime = "*";
                  use = "edit";
                }
              ];
            };
          };
          # Keybindings mapping
          "keymap.toml" = {
            manager = {
              # Using a list of attribute sets maps directly to TOML's array of tables: [[manager.prepend_keymap]]
              prepend_keymap = [
                {
                  on = [ "<C-s>" ];
                  run = "shell \"$SHELL\" --block --confirm";
                  desc = "Open shell here";
                }
                {
                  on = [ "T" ];
                  run = "plugin --sync max-preview";
                  desc = "Maximize or restore preview";
                }
              ];
            };
          };

          # Theme configuration
          "theme.toml" = {
            manager = {
              cwd = {
                fg = "#89b4fa";
              };
              # Hovered file styles
              hovered = {
                fg = "#1e1e2e";
                bg = "#89b4fa";
              };
              preview_hovered = {
                underline = true;
              };
              # Border styles
              border_symbol = "│";
              border_style = {
                fg = "#7f849c";
              };
            };
          };
        };
      };
    };
}
