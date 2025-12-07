{ ... }:

{
  imports = [
    ./apps
 #   ./assets
    ./desktop
    ./development
    ./environment
    ./modules
    ./overlays
    ./security
    ./services
    ./shells
    ./system
    ./utils
    ./virtualization
  ];
    # --- Ix Home Modules ---
  ix = {
    apps.media.audio = {
      spotify.enable = true;
      csound.enable = false;
      ncspot.enable = false;
      puredata.enable = false;
      rmpc.enable = false;
      sonicpi.enable = false;
      supercollider.enable = false;
      tidal.enable = false;
      tidalcycles.enable = false;
      vcv-rack.enable = false;
    };
    development.languages = {
      haskell.enable = true;
    };
  };
    # Custom services
  # NOTE: These are custom services located under home/services, and run as systemd daemons
  userExtraServices = {
    eww.enable = false;
    kmonad.enable = true;
    mako.enable = false;
    neovim-daemon.enable = false;
    swaybg.enable = false;
    system-keyring.enable = true;
    waybar.enable = false;
    wlsunset.enable = false;
    hdmiAutoSwitch.enable = true;
  };

}
