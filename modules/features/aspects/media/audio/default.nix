 {
  flake.nixosModules.audio = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        ncmpcpp
        ncspot
        rmpc
        audacity
        audacious
        audacious-plugins
        csound
        clementine
        easyeffects
        crosspipe
        cavalier
        maxlib
        puredata
        timbreid
        zexy
        supercollider
        tidal-dl
        tidal-hifi
#        vcv-rack
        termusic
        cmus
        haskellPackages.tidal
      ];
  };
}
