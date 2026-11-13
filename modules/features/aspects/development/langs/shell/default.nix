{ ... }: {
  flake.nixosModules.lang-shell = { pkgs, config, lib, ... }: {
    home-manager.users.${config.preferences.user.name} = {
      home.packages = with pkgs; lib.flatten [
        # --- Shell & Core Scripting ---
        bash-language-server
        shfmt
        shellcheck
      ];
    };
  };
}
