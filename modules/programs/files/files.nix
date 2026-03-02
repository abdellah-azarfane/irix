{
  flake.modules.homeManager.files =
    { pkgs, ... }:
    {

      home.packages = with pkgs; [
        filezilla # FTP client
        celeste # File sync client supporting ProtonDrive
        xfce.thunar
        xfce.thunar-volman
        xfce.thunar-archive-plugin
      ];
    };
}
