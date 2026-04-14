{ self, inputs, ... }: {
  flake.nixosConfigurations.pi-runner = self.lib.mkNixos {
    system = "aarch64-linux";

    modules = [
      self.nixosModules.hostProfileServer
      inputs.nixos-hardware.nixosModules.raspberry-pi-3

      ({ modulesPath, ... }: {
        imports = [ "${modulesPath}/installer/sd-card/sd-image-aarch64.nix" ];
        nixpkgs.config.allowUnfree = true;
      })

      ({ config, lib, pkgs, ... }: {
        features.optionalServices.pipewire = lib.mkForce false;

        services.greetd.enable = lib.mkForce false;
        services.xserver.enable = lib.mkForce false;

        boot.binfmt.emulatedSystems = lib.mkForce [];
        boot.kernelPackages = lib.mkForce pkgs.linuxPackages;
        hardware.cpu.intel.updateMicrocode = lib.mkForce false;

        zramSwap.enable = true;
        swapDevices = [ { device = "/var/lib/swapfile"; size = 2048; } ];

        boot.loader.grub.enable = false;
        boot.loader.systemd-boot.enable = lib.mkForce false;
        boot.loader.generic-extlinux-compatible.enable = true;
        hardware.enableRedistributableFirmware = true;

        networking.hostName = "pi-runner";

        users.users.abosafiya = {
          isNormalUser = true;
          group = "abosafiya";
          extraGroups = [ "wheel" ];
        };
        users.groups.abosafiya = {};
        home-manager.users.abosafiya.home.stateVersion = "26.05";

        services.gitlab-runner = {
          enable = true;
          services.default = {
            executor = "shell";
            registrationConfigFile = "/etc/gitlab-runner/registration.env";
            tagList = [ "arm64" "pi3b" ];
          };
        };
      })
    ];
  };
}
