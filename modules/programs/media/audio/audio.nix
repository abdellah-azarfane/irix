{
  flake.modules.homeManager.media =
    { pkgs, ... }:
    {
  programs = {
    ########
    ncmpcpp = {
      enable = true; # Curses-based interface for MPD (music player daemon)
    };
    ########
    ncspot = {
      enable = false;
      settings = {
        gapless = false;
      };
    };
    ########
    rmpc = {
      enable = true; # Beautiful, modern and configurable terminal based Music Player Daemon client
    };
    ######

  };
  home.packages = with pkgs; [
    audacity
    audacious
    audacious-plugins
    csound
    clementine
    easyeffects # Equalizer for PipeWire
    helvum # GTK patchbay for PipeWire
    playerctl # CLI util & lib for controlling audio
    cavalier # Terminal audio visualizer
    maxl # PureData non-tilde externals
    puredata # Real time interface for audio & video signal processing
    timbreid # PureData Utils
    zexy # PureData utils
    sonic-pi # Live coding music synth
    supercollider # Audio synthesis and algorithmic composition environment
    tidal-dl # Downloader for tidal media
    tidal-hifi # Tidal GUI running on Electron
    haskellPackages.tidal # TidalCycles live coding environment for music
    vcv-rack # Virtual modular synthesizer
    vcv-rack-plugins # Collection of plugins for VCV Rack
    # --- TUI Music Players ---
    termusic # Feature-rich music player in Rust
    cmus # Small, fast console music player
  ];
 };
}
