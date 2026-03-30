{ self, lib, ... }: {
  flake.nixosModules.shell-common = { pkgs, config, ... }: let 
    inherit (lib) getExe getExe';
    user = config.preferences.user.name;
    selfpkgs = self.packages.${pkgs.stdenv.hostPlatform.system};

    myAliases = {
      ls = "${getExe pkgs.eza} --all --color=auto --classify --group-directories-first --sort=newest --icons";
      l = "${getExe pkgs.eza} --all --long --git --header --color=auto --group-directories-first --classify --color-scale=all --sort=newest --icons=auto --octal-permissions";
      cat = "${getExe pkgs.bat} --pager \"never\"";
      lg = "${getExe pkgs.lazygit}";
      nv = "${getExe selfpkgs.neovimDynamic}";
      y = "${getExe pkgs.yazi}";
      # Nix aliases
      n = "nix";
      nr = "nix run";
      nd = "nix develop";
      nf = "nix fmt";
      nhs = "${getExe pkgs.nh} search";
      # Cargo aliases
      cr = "${getExe pkgs.cargo}";
      crb = "${getExe pkgs.cargo} build";
      crt = "${getExe pkgs.cargo} test";
    };

  in {
    home-manager.users.${user} = {
      home.shellAliases = myAliases;

    
      programs.zoxide.enable = true;
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
      programs.carapace.enable = true;

      programs.starship = {
        enable = true;
        settings = {
          add_newline = true;
          directory.substitutions = {
            "Documents" = "󰈙 ";
            "Downloads" = " ";
            "Music" = " ";
            "Pictures" = " ";
          };
        };
      };

      home.packages = with pkgs; [
        selfpkgs.neovimDynamic
        carapace-bridge
        vivid
        python3Packages.sparklines # Used for your custom clear-screen script
        lolcat
      ];
    };
  };
}