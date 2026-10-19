{
  flake.nixosModules.productivity = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      maxima
      wxmaxima
      antigravity-ide
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
