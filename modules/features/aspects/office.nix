{...}: {
  flake.nixosModules.office = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        onlyoffice-desktopeditors
        libreoffice
        zoom-us
      ];
    };
}
