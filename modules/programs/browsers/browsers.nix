{
  flake.modules.homeManager.browsers =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        brave
        tor
        # --- Terminal Browsers ---
        w3m # Text-mode WWW browser
        lynx # Classic text browser
        browsh # Modern text-based browser using Firefox
      ];
      programs.firefox = {
        enable = true;
      };
      programs.librewolf = {
        enable = true;
      };
    };
}
