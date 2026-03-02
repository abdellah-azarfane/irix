{
  flake-file.inputs = {
    niri-flake = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  flake.modules.nixos.niri =
    {
      pkgs,
      config,
      inputs,
      ...
    }:
    {
      imports = [ inputs.niri-flake.nixosModules.niri ];
      environment.systemPackages = with pkgs; [
        wl-clipboard # Clipboard support
        wl-mirror # Screen mirroring
        wf-recorder # Screen recording
        wayland-utils # Wayland debugging tools
        wev # Key event viewer (useful for finding key names)
        wlr-randr # Output management
        pkgs.xwayland-satellite # X11 app support (non-native on niri)
        dragon-drop # Drag and drop for wayland
      ];
      environment.sessionVariables = {
        NIXOS_OZONE_WL = "1"; # Hint Electron apps to use Wayland
        # XDG directories
        XDG_CURRENT_DESKTOP = "niri";
        XDG_SESSION_TYPE = "wayland";
        # For Qt apps
        QT_QPA_PLATFORM = "wayland";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        # For SDL apps
        SDL_VIDEODRIVER = "wayland";
      };
      programs.niri = {
        enable = true;
        package = pkgs.niri;
      };

      services.dbus = {
        enable = true; # Required for niri wm
      };

      # Desktop portals
      # NOTE: Niri requires xdg-desktop-portal-gnome for screencasting (not wlr).
      # The programs.niri module already adds xdg-desktop-portal-gnome and niri-portals.conf.
      xdg.portal = {
        enable = true;
        # wlr.enable = true; # DISABLED: wlr portal doesn't work with Niri
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal-termfilechooser # Portal for using TUIs as file pickers
        ];
      };
      # Required by xdg-desktop-portal-gnome for file chooser dialogs
      services.dbus.packages = [ pkgs.nautilus ];
    };
}
