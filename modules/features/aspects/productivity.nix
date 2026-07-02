 {
  flake.nixosModules.productivity = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        libqalculate
        qalculate-gtk
        calcure
        taskwarrior3
        pomodoro
        blanket
        yad
      ];
    };
}
