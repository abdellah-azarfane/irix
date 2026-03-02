{
  flake.modules.homeManager.utils =
    { ... }:
    {
      programs.bat = {
        enable = true;
      };
    };
}
