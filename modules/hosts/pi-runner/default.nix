{ self, inputs, ... }: {
  flake.nixosConfigurations.pi-runner = self.lib.mkNixos {
    system = "aarch64-linux";

    modules = [
      self.nixosModules.hostProfileServer
      inputs.nixos-hardware.nixosModules.raspberry-pi-3

      ({ config, lib, pkgs, ... }: {
        fileSystems."/" = {
          device = "/dev/disk/by-label/NIXOS_SD";
          fsType = "ext4";
          options = [ "noatime" ]; 
        };

        boot.loader.grub.enable = false;
        boot.loader.systemd-boot.enable = lib.mkForce false;
        boot.loader.generic-extlinux-compatible.enable = true;
        
        # From zupo/nix: clock speed fix & headless optimization
        boot.loader.raspberryPi.firmwareConfig = ''
          force_turbo=1
          avoid_warnings=1
          gpu_mem=16
        '';

        hardware.enableRedistributableFirmware = true;
        hardware.cpu.intel.updateMicrocode = lib.mkForce false;

        boot.binfmt.emulatedSystems = lib.mkForce [];
        boot.kernelPackages = lib.mkForce pkgs.linuxPackages;

        zramSwap.enable = true;
        swapDevices = [ { device = "/var/lib/swapfile"; size = 2048; } ];

        features.optionalServices.pipewire = lib.mkForce false;
        services.greetd.enable = lib.mkForce false;
        services.xserver.enable = lib.mkForce false;

        networking.hostName = "pi-runner";

        # From zupo/nix: Static IP (Uncomment & adjust if needed)
        # networking.interfaces.eth0.ipv4.addresses = [{
        #   address = "192.168.1.33";
        #   prefixLength = 24;
        # }];
        # networking.defaultGateway = "192.168.1.3";
        # networking.nameservers = [ "8.8.8.8" ];

        users.users.abosafiya = {
          isNormalUser = true;
          group = "abosafiya";
          extraGroups = [ "wheel" ];
        };
        users.groups.abosafiya = {};
        
        home-manager.users.abosafiya.home.stateVersion = "26.05";

        users.users.gitlab-runner = {
          isSystemUser = true;
          group = "gitlab-runner";
          extraGroups = [ "wheel" ];
        };
        users.groups.gitlab-runner = {};

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
