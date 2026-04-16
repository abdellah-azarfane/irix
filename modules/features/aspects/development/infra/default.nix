{
  flake.nixosModules.infra = { pkgs, ... }:
  let
    # Temporary hash pin to work around upstream kdash vendor hash drift.
    kdashFixed = pkgs.kdash.overrideAttrs (old: {
      cargoDeps = old.cargoDeps.overrideAttrs (_: {
        outputHash = "sha256-7eK33kMAFaK0Uj6udvQc9EQUISkOTFapztpMaCEUMGA=";
      });
    });
  in {
  environment.systemPackages = with pkgs; [
    # --- Terraform ---
    terraform
    terraform-ls # Official language server

    # --- Kubernetes TUI ---
    k9s # Kubernetes TUI management
    kdashFixed # Simple and fast Kubernetes dashboard

    # --- Docker TUI ---
    lazydocker # Docker management TUI
    dive # Docker image layer analysis
    ctop # Top-like interface for containers
  ];
};
}
