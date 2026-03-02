{
  flake.modules.homeManager.neovim =
    {
      pkgs,
      lib,
      ...
    }:
    {
      programs.neovide = {
        enable = false;
        settings = {
          # --- Window Behavior ---
          fork = false;
          frame = "full";
          idle = true;
          maximized = false;
          title-hidden = false;
          vsync = true;
          tabs = true;
          theme = "auto";

          # --- Performance & Rendering ---
          srgb = false;
          no-multigrid = false;

          # --- Mouse ---
          mouse-cursor-icon = "arrow";

          # --- Font Configuration ---
          font = {
            normal = [ "JetBrainsMono Nerd Font" ];
            size = 12.0;
            hinting = "full";
            edging = "antialias";

            # --- Font Features ---
            # --- Font Features ---
            features = {
              "JetBrainsMono Nerd Font" =
                "+ss01 
                +ss02 
                +ss03 
                +ss04 
                +ss05 
                +ss06 
                +ss07 
                +ss08 
                +ss09 
                +ss19 
                +ss20 
                +calt 
                +liga";
            };

            # --- Box Drawing ---
            box-drawing = {
              mode = "native";
            };

            # --- Crash Reporting ---
            backtraces_path = "~/.local/share/neovide/neovide_backtraces.log";
          };
        };
      };
    };
}
