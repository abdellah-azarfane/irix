{...}: {
  flake.nixosModules.office = {pkgs, config, ...}: {
      environment.systemPackages = with pkgs; [
        onlyoffice-desktopeditors
        libreoffice
        zoom-us
      ];
    };
}
