# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    ../home
  ];



  # TODO: Set your username
  home = {
    username = "hermonyx";
    homeDirectory = "/home/hermonyx";
  };
  home.stateVersion = "26.05";
}
