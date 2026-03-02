{
  flake.modules.homeManager.utils =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        procs # Rustified ps
        htop # Classic process viewer
        glances # Swiss Army knife monitor with web dashboard
        zenith # System monitor with zoomable charts
      ];
    };
}
