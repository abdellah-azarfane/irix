{
  flake.nixosModules.productivity = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      maxima
      wxmaxima
      codeblocksFull
      gnuplot
      calcure
      taskwarrior3
      pomodoro
      blanket
      yad
    ];
  };
}
