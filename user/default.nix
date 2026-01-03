# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
      ../home/apps
 #   ../assets
      ../home/desktop
      ../home/development
      ../home/environment
      ../home/modules
      ../home/overlays
      ../home/security
      ../home/services
      ../home/shells
      ../home/system
      ../home/utils
      ../home/virtualization
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
  # TODO: Set your username
  home = {
    username = "zayron";
    homeDirectory = "/home/zayron";
  };
  home.stateVersion = "26.05";
}
