{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

{
  options.extraRules.keychronUdev.enable = mkEnableOption "Keychron V1 user‑service trigger";

  config = mkIf config.extraRules.keychronUdev.enable {
    # NOTE:
    # For this to work, the following needs to be run:
    #   sudo loginctl enable-linger {username}
    # Where {username} = user name
    users.extraUsers.hermonyx.linger = true;
    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="input", KERNEL=="event*", \
        ATTRS{idVendor}=="3434", ATTRS{idProduct}=="0311", \
        TAG+="systemd", \
        ENV{SYSTEMD_USER_WANTS}+="kmonad-keychron.service"
    '';
  };
}
