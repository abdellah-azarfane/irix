{
  flake.nixosModules.unfree = { lib, config, ... }: {

    nixpkgs.config = {
      # Only allow specific unfree packages
      allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [

        # --- Core System & Drivers ---
        "nvidia-x11"
        "nvidia-settings"

        # Required strictly because of native services.ollama.acceleration = "cuda";
        "cuda_cudart"
        "cuda_nvcc"
        "cuda_cccl"
        "libcublas"

        # --- Utilities ---
        "rar"
        "winbox"

        # --- Hardware Firmware (Required if enabling these chips) ---
        "broadcom-bt-firmware"
        "b43-firmware"
        "xone-dongle-firmware"
        "facetimehd-calibration"
        "facetimehd-firmware"
      ];

      permittedInsecurePackages = [
         "pnpm-10.34.0"
         "pnpm-10.29.2"
      ];
    };
   };
}
