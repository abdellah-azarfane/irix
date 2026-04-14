{ ... }:
{
  flake.nixosModules.nvidia = {
    pkgs,
    config,
    ...
  }: {
    # X11 / Wayland drivers
    services.xserver.videoDrivers = ["nvidia"];

    # NVIDIA drivers
    hardware.nvidia = {
      open = false;
      # Now config.boot works perfectly!
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      modesetting.enable = true;
      nvidiaSettings = true;
      powerManagement.enable = true;
      dynamicBoost.enable = true;

      # PRIME offload (Intel + NVIDIA hybrid laptops)
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
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
        intel-compute-runtime
        intel-media-driver
        (intel-vaapi-driver.override {enableHybridCodec = true;})
        libva-vdpau-driver
        libvdpau-va-gl
        mesa
        nvidia-vaapi-driver
        nv-codec-headers-12
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        intel-media-driver
        (intel-vaapi-driver.override {enableHybridCodec = true;})
        libva-vdpau-driver
        libvdpau-va-gl
        mesa
      ];
    };

    # System packages
    environment.systemPackages = with pkgs; [
      egl-wayland
      nvidia-vaapi-driver
      libvdpau-va-gl
      cudaPackages.cudatoolkit
      cudaPackages.cudnn
      vulkan-tools-lunarg
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
