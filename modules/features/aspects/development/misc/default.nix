{
  flake.nixosModules.misc = { pkgs, ... }:{
  environment.systemPackages = with pkgs; [
    # --- API Clients ---
    atac # Feature-full API client TUI in Rust

    # --- JSON Tools ---
    fx # Terminal JSON viewer & processor
  ];
};
}
