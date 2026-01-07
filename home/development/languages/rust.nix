{ pkgs, inputs, ... }:

let
  system = pkgs.stdenv.hostPlatform.system;
  fenixPkgs = inputs.fenix.packages.${system};
in
{
  home.packages = with pkgs; [
    # --- Rust ---
    fenixPkgs.stable.toolchain
    fenixPkgs.rust-analyzer
    bacon # Background rust code checker
    cargo-info # Cargo subcommand to show crates info from crates.io
  ];
}
