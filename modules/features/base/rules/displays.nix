{
  flake.modules.nixos.base =
    { pkgs, ... }:
    {
      services.udev.extraRules = ''
        ACTION=="change", SUBSYSTEM=="drm", ENV{HOTPLUG}=="1", \
          DEVPATH=="*/drm/card1", \
          RUN+="${pkgs.util-linux}/bin/runuser -u abosafiya -- ${pkgs.systemd}/bin/systemctl --user start --no-block rh-hdmi-hotplug.service"
      '';
    };
}
