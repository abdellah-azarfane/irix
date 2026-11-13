{
  flake.nixosModules.mandara =
    {
      inputs,
      config,
      pkgs,
      ...
    }:
    {
      imports = [
        inputs.mandara.nixosModules.default
      ];

      programs.mandara = {
        enable = true;
        package = inputs.mandara.packages.${pkgs.system}.default.overrideAttrs (oldAttrs: {
          buildInputs = (oldAttrs.buildInputs or [ ]) ++ [ pkgs.zstd ];
        });
        # Mandara Login (greetd + cage) replaces the previous display-manager
        # greeter with the new shell.
        greeter.enable = true;
      };
    };
}
