{
  flake.modules.homeManager.quickshell =
    { pkgs, lib, ... }:
    let
      # This block perfectly replaces their "default.nix" wrapper!
      quickshell-wrapped = pkgs.symlinkJoin {
        name = "quickshell-wrapped";
        paths = [ pkgs.quickshell ];
        buildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          wrapProgram $out/bin/quickshell \
            --prefix PATH : ${lib.makeBinPath [ pkgs.zoxide ]} \
            --add-flags "-c ${./.}" 
        '';
      };
    in
    {
      # 1. Install the program
      home.packages = [
        quickshell-wrapped
        pkgs.zoxide
      ];

      # 2. Automatically start it when you log in
      systemd.user.services.quickshell = {
        Unit = {
          Description = "Quickshell Custom UI";
          PartOf = [ "graphical-session.target" ];
          After = [ "graphical-session.target" ];
        };
        Service = {
          ExecStart = "${quickshell-wrapped}/bin/quickshell";
          Restart = "on-failure";
        };
        Install = {
          WantedBy = [ "graphical-session.target" ];
        };
      };
    };
}
