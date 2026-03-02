{
  flake.modules.nixos.main-user =
    { pkgs, ... }:
    {
      users.users.abosafiya = {
        name = "abosafiya";
        isNormalUser = true;
        description = "Abdellah Azarfane";
        extraGroups = [
          "wheel"
          "networkmanager"
          "docker"
          "input"
          "uinput"
          "video"
        ];
        shell = pkgs.zsh;
        home = "/home/abosafiya";
        # openssh = {
        #   authorizedKeys.keys = [
        #   ];
        # };
      };

      # NOTE: Required for devenv
      nix.settings.trusted-users = [
        "root"
        "abosafiya"
      ];
      home-manager.backupFileExtension = "backup"; # HACK: Required since hm activation was sometimes faulty
      users.defaultUserShell = pkgs.zsh; # Default shell for all users
    };
}
