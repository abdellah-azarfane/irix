{
  flake.modules.homeManager.servers =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        plex
        plexamp
      ];
    };
}
