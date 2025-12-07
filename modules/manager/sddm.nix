{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.manager.sddm;
in
{
  options.manager.sddm = {
    enable = mkEnableOption "SDDM display manager with custom configuration";
  };

  config = mkIf cfg.enable {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "breeze";
      settings = {
        General = {
          DefaultSession = "niri";
          DisplayServer = "wayland";
          RememberLastUser = true;
          RememberLastSession = true;
          LoginTimeout = 120;
          SessionTimeout = 60;
        };
    };
  };

  # Add optional tools
  environment.systemPackages = with pkgs; [
   kdePackages.sddm-kcm # GUI settings (works in Plasma, optional)
  ];
    security.pam.services.sddm.enableGnomeKeyring = true;
    security.pam.services.sddm-greeter.enableGnomeKeyring = true;
    security.polkit.enable = true;
    environment.sessionVariables = {
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_WAYLAND_FORCE_DPI = "physical";
    };
  };
}
