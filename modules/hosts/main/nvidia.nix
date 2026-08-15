{
  flake.nixosModules.nvidia =
    { pkgs, config, ... }:
    {
      # X11 / Wayland drivers
      services.xserver.videoDrivers = [ "nvidia" ];

      # NVIDIA drivers
      hardware.nvidia = {
        open = true; # Requires Turing (GTX 16xx / RTX 20xx) or newer
        package = config.boot.kernelPackages.nvidiaPackages.latest;
        modesetting.enable = true;
        nvidiaSettings = true;

        powerManagement = {
          enable = true;
          # Enables complete power down of the dGPU when not rendering
          finegrained = true;
        };

        dynamicBoost.enable = true;

        # PRIME offload (Intel + NVIDIA hybrid laptops)
        prime = {
          offload = {
            enable = true;
            # Automatically generates and installs the nvidia-offload script
            enableOffloadCmd = true;
          };
          nvidiaBusId = "PCI:1:0:0"; # Must match your specific hardware
          intelBusId = "PCI:0:2:0"; # Must match your specific hardware
        };
      };

      # Hardware graphics configuration (replaces hardware.opengl)
      hardware.graphics = {
        enable = true;
        enable32Bit = true;

        extraPackages = with pkgs; [
          intel-media-driver
          intel-compute-runtime
          nvidia-vaapi-driver
          libva-vdpau-driver
        ];
      };

      # System packages
      environment.systemPackages = with pkgs; [
        vulkan-tools
      ];

      # Session / environment variables
      environment.sessionVariables = {
        NVD_BACKEND = "direct";
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
        NIXOS_OZONE_WL = "1";
      };

      # Containers support (Docker, Podman)
      hardware.nvidia-container-toolkit.enable = true;
    };
}
