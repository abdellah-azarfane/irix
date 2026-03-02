{
  flake.modules.nixos.base =
    { pkgs, lib, ... }:
    {
      environment.systemPackages = with pkgs; [
        tlp
        auto-cpufreq
      ];
      services.supergfxctl.enable = true; # Critical for switching off Nvidia
      services.auto-cpufreq.enable = true;
      services.tlp = {
        enable = true;
        settings = {
          # --- THE CRITICAL FIX ---
          # Disable TLP's CPU management so auto-cpufreq takes over
          CPU_CONFIG_ON_AC = 0;
          CPU_CONFIG_ON_BAT = 0;
          CPU_SCALING_GOVERNOR_ON_AC = "null"; # or leave empty
          CPU_SCALING_GOVERNOR_ON_BAT = "null";

          # --- Battery Health (Asus Specific) ---
          START_CHARGE_THRESH_BAT0 = 60;
          STOP_CHARGE_THRESH_BAT0 = 80;

          # --- Radio & Performance ---
          WIFI_PWR_ON_AC = "on";
          WIFI_PWR_ON_BAT = "on";

          # --- GPU Management ---
          # Note: If you have an Intel + Nvidia setup,
          # TLP's runtime PM can sometimes crash the Nvidia driver.
          RUNTIME_PM_ON_AC = "auto";
          RUNTIME_PM_ON_BAT = "auto";
          RUNTIME_PM_DENYLIST = [ "nvidia" ];

          # Graphics power management
          INTEL_GPU_MIN_FREQ_ON_AC = 600;
          INTEL_GPU_MIN_FREQ_ON_BAT = 300; # Lowered for better battery

          # Sleep states
          MEM_SLEEP_ON_AC = "deep";
          MEM_SLEEP_ON_BAT = "deep";
        };
      };

      # Disable the default GNOME/KDE power management daemon
      # This is vital even on a WM to prevent interference
      services.power-profiles-daemon.enable = lib.mkForce false;
    };
}
