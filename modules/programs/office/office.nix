{
  flake.modules.homeManager.office =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        onlyoffice-desktopeditors
        libreoffice
        #  slack
        #  teams-for-linux
        zoom-us
      ];
    };
}
