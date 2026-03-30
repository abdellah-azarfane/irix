{
  flake.nixosModules.misc = { pkgs, ... }:{
  environment.systemPackages = with pkgs; [
    # --- API Clients ---
    atac # Feature-full API client TUI in Rust

    # --- JSON Tools ---
    jqp # Interactive jq playground
    fx # Terminal JSON viewer & processor
  ];
};
}
