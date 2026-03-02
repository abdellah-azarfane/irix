{
  flake.modules.homeManager.utils =
    { pkgs, ... }:
    {
      programs = {
        jq = {
          enable = true;
        };

        ripgrep = {
          enable = true;
        };

        ripgrep-all = {
          enable = true;
        };
      };

      home.packages = with pkgs; [
        fselect # Find files with SQL-like queries
        plocate # A much faster locate
        repgrep # Interactive find & replace within files
        sd # Sed alternative
      ];
    };
}
