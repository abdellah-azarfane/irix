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
        package = pkgs.yazi;

        files = {
          "yazi.toml" = {
            flavor = {
              use = "wallust";
            };
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
                  run = "neovide %s";
                  block = false;
                  desc = "Neovim";
                  for = "unix";
                }
              ];
            emacs = [
                {
                 run = "emacsclient -c -a \"\" %s";
                 block = false;
                 desc = "Emacs";
                 for = "unix";
                }
              ];
              image = [
                {
                  run = "imv %s";
                  block = false;
                  desc = "imv";
                  for = "unix";
                }
              ];
              video = [
                {
                  run = "mpv %s";
                  block = false;
                  desc = "mpv";
                  for = "unix";
                }
              ];
              audio = [
                {
                  run = "mpv %s";
                  block = false;
                  desc = "mpv";
                  for = "unix";
                }
              ];
              pdf = [
                {
                  run = "zathura %s";
                  block = false;
                  desc = "Zathura";
                  for = "unix";
                }
              ];
              office = [
                {
                  run = "onlyoffice-desktopeditors %s";
                  block = false;
                  desc = "OnlyOffice";
                  for = "unix";
                }
              ];
              libre = [
                {
                  run = "libreoffice %s";
                  block = false;
                  desc = "LibreOffice";
                  for = "unix";
                }
              ];
              browser = [
                {
                  run = "zen-beta %s";
                  block = false;
                  desc = "Zen Browser";
                  for = "unix";
                }
              ];
            };

            # File mapping rules
            open = {
              rules = [
                {
                  url = "*.{docx,doc,xlsx,xls,pptx,ppt}";
                  use = "office";
                }
                {
                  mime = "application/vnd.oasis.opendocument.*";
                  use = "libre";
                }
                {
                  mime = "application/pdf";
                  use = "pdf";
                }
                {
                  mime = "image/*";
                  use = "image";
                }
                {
                  mime = "video/*";
                  use = "video";
                }
                {
                  mime = "audio/*";
                  use = "audio";
                }
                {
                  mime = "text/html";
                  use = "browser";
                }
                {
                  mime = "text/*";
                  use = [ "edit" ];
                }
                {
                  url = "*.{nix,lua,conf,ini,cfg,vim,sh,bash,zsh,fish,nu,Xresources}";
                  use = [ "edit" ];
                }
                {
                  url = "*.{js,jsx,ts,tsx,html,htm,xhtml,css,scss,sass,less,xml,graphql}";
                  use = [ "edit" ];
                }
                {
                  url = "*.{py,rs,go,c,h,hpp,cpp,java,rb,php,hs,sql,proto}";
                  use = [ "edit" ];
                }
                {
                  url = "*.{md,markdown,rst,tex}";
                  use = [ "edit" ];
                }
                {
                  url = "*.org";
                  use = "emacs";
                }
                {
                  url = "*.{toml,json,yaml,yml}";
                  use = [ "edit" ];
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
        };
      };
    };
}
