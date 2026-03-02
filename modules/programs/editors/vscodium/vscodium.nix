{
  flake.modules.homeManager.editors =
    {
      pkgs,
      lib,
      ...
    }:
    {
      programs.vscode = {
        enable = true;
        package = pkgs.vscodium;
        mutableExtensionsDir = true; # Can VS Code modify extensions directory? Of course not
        profiles = {
          default = {
            enableUpdateCheck = false; # Silence the mf
          };
        };
      };
    };
}
