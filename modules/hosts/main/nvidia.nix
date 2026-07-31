{ ... }:
{
  flake.nixosModules.nvidia =
    {
      pkgs,
      config,
      ...
    }:
    {
      # Force the memory preservation parameter at the kernel level
      boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];

      # X11 / Wayland drivers
      services.xserver.videoDrivers = [ "nvidia" ];

      # NVIDIA drivers
      hardware.nvidia = {
        open = true;
        package = config.boot.kernelPackages.nvidiaPackages.latest;
        modesetting.enable = true;
        nvidiaSettings = true;

        powerManagement = {
          enable = true;
          finegrained = false; # Explicitly set this to false
        };

        dynamicBoost.enable = true;

        # PRIME offload (Intel + NVIDIA hybrid laptops)
        prime = {
          offload = {
            enable = true; # Changed to true
            enableOffloadCmd = true; # Changed to true
          };
          nvidiaBusId = "PCI:1:0:0";
          intelBusId = "PCI:0:2:0";
        };
      };

      # Hardware graphics configuration
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
        egl-wayland
        vulkan-tools
        (pkgs.writeShellScriptBin "nvidia-offload" ''
          export LIBVA_DRIVER_NAME=nvidia
          export __NV_PRIME_RENDER_OFFLOAD=1
          export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
          export __GLX_VENDOR_LIBRARY_NAME=nvidia
          export __VK_LAYER_NV_optimus=NVIDIA_only
          exec "$@"
        '')
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
