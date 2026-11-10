{
  flake.nixosModules.productivity = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      maxima
      wxmaxima
      codeblocksFull
      gnuplot
      calcure
#      taskwarrior3 # FIXME: temporarily commented out - taskchampion fails to link sqlite3 in current nixpkgs master
      pomodoro
      blanket
      yad
    ];
  };
}
