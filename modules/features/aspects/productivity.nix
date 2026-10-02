{
  flake.nixosModules.productivity = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      maxima
      wxmaxima
      staruml
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
