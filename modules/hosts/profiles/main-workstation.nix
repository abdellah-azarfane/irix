{ self, inputs, ... }:
{
  flake.nixosModules.hostProfileMainWorkstation =
    { pkgs, config, ... }:
    {
      programs.fish.enable = true;

      imports = [
        self.nixosModules.hostProfileLaptop
        self.nixosModules.preferences
        self.nixosModules.MainWorkstationHardwareConfig
        self.nixosModules.nvidia
        self.lib.diskoConfigurations.MainWorkstation
      ];

      users.users.${config.preferences.user.name} = {
        isNormalUser = true;
        description = "${config.preferences.user.name}'s account";
        extraGroups = [
          "wheel"
          "docker"
          "input"
          "uinput"
          "video"
        ];
        shell = pkgs.fish;
        initialHashedPassword = "$6$mhUXobPRIxAenNMe$EjE8vQ2kbr5Ia1W1g/vltxOo.fz1wwsDVPMvsiG1gvC/mGFms92ZdDuwhLiqbadOW/k2x8gGOSx/kQtK5FLZ3/";
        # NOTE: change this password on first login via `passwd`
      };
      features.optionalServices = {
        greetd = true;
        xserver = true;
        pipewire = true;
        upower = true;
        ppd = true;
        tuned = false;
        printing = true;
        udisks2 = true;
        blueman = true;
        flatpak = true;
        openrgb = true;
        asusd = true;
        ollama = true;
      };

      # Keep disk swap for hibernation, and use zram as a fast compression tier.
      zramSwap = {
        enable = true;
        memoryPercent = 50;
        algorithm = "zstd";
      };
      boot.resumeDevice = "/dev/nvme0n1p2";
      home-manager.users.${config.preferences.user.name} = {
        home.stateVersion = "26.05";
      };
    };
}
