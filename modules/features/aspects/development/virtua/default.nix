{
  flake.nixosModules.virt =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    let
      user = config.preferences.user.name;
    in
    {
      environment.systemPackages = with pkgs; [
        winbox
        winboat
        remmina
        # --- Kubernetes TUI ---
        k9s # Kubernetes TUI management

        # --- Docker TUI ---
        lazydocker # Docker management TUI
        docker-compose

      ];

      # Ensure graphics drivers are actually enabled
      hardware.graphics.enable = lib.mkDefault true;
      virtualisation.libvirtd.enable = true;
      users.users.${user}.extraGroups = [
        "libvirtd"
        "kvm"
      ];
      services.zerotierone.enable = true;
      virtualisation.docker = {
        enable = true;
        autoPrune.enable = true;
        enableOnBoot = true;
      };
    };

}
