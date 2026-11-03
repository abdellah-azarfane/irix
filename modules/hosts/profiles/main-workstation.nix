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

      # The primary user account itself is owned by modules/base/user.nix
      # (via the `preferences.user` options) — including the fish shell.
      # Only add host-specific extras here to avoid redefining the same
      # options twice (which NixOS rejects as non-unique).
      users.users.${config.preferences.user.name}.extraGroups = [
        "docker"
        "uinput"
      ];
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
        home.stateVersion = "26.11";
      };
    };
}
