 {
  flake.nixosModules.productivity = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        libqalculate
        qalculate-gtk
        element
        calcure
        taskwarrior3
        taskwarrior-tui
        uair
        pom
        openpomodoro-cli
        yad
      ];
    };
}
