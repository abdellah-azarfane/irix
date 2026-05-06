{ self, lib, ... }: let
  mkShellAliasesLib = { pkgs, lib }: let
    inherit (lib) getExe;
    selfpkgs = self.packages.${pkgs.stdenv.hostPlatform.system};
  in {
    # Navigation
    c = "clear";
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
    md = "mkdir -p";

    # Files and viewing
    ls = "${getExe pkgs.eza} --all --color=auto --classify --group-directories-first --sort=newest --icons";
    l = "${getExe pkgs.eza} --all --long --git --header --color=auto --group-directories-first --classify --color-scale=all --sort=newest --icons=auto --octal-permissions";
    lt = "${getExe pkgs.eza} --all --tree --level=2 --icons";
    cat = "${getExe pkgs.bat} --paging=never";
    more = "${getExe pkgs.bat} --paging=always";
    y = "${getExe pkgs.yazi}";
    v = "${getExe selfpkgs.neovimDynamic}";
    nv = "${getExe selfpkgs.neovimDynamic}";
    lg = "${getExe pkgs.lazygit}";

    # Git
    g = "${getExe pkgs.git}";
    ga = "${getExe pkgs.git} add";
    gaa = "${getExe pkgs.git} add --all";
    gc = "${getExe pkgs.git} commit";
    gca = "${getExe pkgs.git} commit --amend";
    gco = "${getExe pkgs.git} checkout";
    gd = "${getExe pkgs.git} diff";
    gds = "${getExe pkgs.git} diff --staged";
    gl = "${getExe pkgs.git} log --oneline --graph --decorate --all";
    gp = "${getExe pkgs.git} push";
    gpl = "${getExe pkgs.git} pull --rebase";
    gs = "${getExe pkgs.git} status";

    # Nix
    n = "nix";
    nr = "nix run";
    nd = "nix develop";
    nf = "nix fmt";
    nfc = "nix flake check";
    nfu = "nix flake update";
    nsp = "nix search nixpkgs";
    nhs = "${getExe pkgs.nh} search";
    nrb = "sudo nixos-rebuild boot --flake .#main";
    nrs = "sudo nixos-rebuild switch --flake .#main";
    nrt = "sudo nixos-rebuild test --flake .#main";

    # Cargo
    cr = "${getExe pkgs.cargo}";
    crb = "${getExe pkgs.cargo} build";
    crt = "${getExe pkgs.cargo} test";
    crc = "${getExe pkgs.cargo} check";

    # Process and system helpers
    psg = "ps aux | grep";
    ports = "ss -tulpn";
    du1 = "du -h --max-depth=1";
  };

  mkFishShellInitLib = { pkgs, lib }: ''
    set fish_greeting
    fish_vi_key_bindings

    ${lib.getExe pkgs.zoxide} init fish | source

    function lf --wraps="lf" --description="lf - Terminal file manager (changing directory on exit)"
        cd "$(command lf -print-last-dir $argv)"
    end

    if type -q direnv
        direnv hook fish | source
    end

    function fish_prompt
        string join "" -- (set_color red) "[" (set_color yellow) $USER (set_color green) "@" (set_color blue) $hostname (set_color magenta) " " $(prompt_pwd) (set_color red) "]" (set_color normal) "\$ "
    end
  '';
in
{
  flake.lib = {
    mkShellAliases = mkShellAliasesLib;
    mkFishShellInit = mkFishShellInitLib;
  };

  flake.nixosModules.shell-common = { pkgs, config, ... }: let
    user = config.preferences.user.name;
    selfpkgs = self.packages.${pkgs.stdenv.hostPlatform.system};
    myAliases = mkShellAliasesLib { inherit pkgs lib; };
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
            "downloads" = " ";
            "pictures" = " ";
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