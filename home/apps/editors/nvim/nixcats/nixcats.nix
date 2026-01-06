{ inputs, ... }:
{
  defaultPackageName = "nvim";

  categoryDefinitions = { pkgs, ... }: {
    # Minimal starter set; expand as you like.
    runtime = {
      # Extra runtime deps available inside Neovim.
      general = with pkgs; [
        ripgrep
        fd
        git
      ];
    };

    plugins = {
      general = {
        # Plugin selection is handled by nixCats' plugin overlay.
        # We keep the Lua config lightweight; add/remove plugins as desired.
      };
    };
  };

  packageDefinitions = { pkgs, ... }: {
    nvim = {
      # Enable categories for this package.
      categories = {
        runtime = {
          general = true;
        };
        plugins = {
          general = true;
        };
      };
    };
  };
}
