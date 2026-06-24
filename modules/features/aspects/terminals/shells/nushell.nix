{ self, lib, ... }: {
  flake.nixosModules.nushell = { pkgs, config, ... }: let
    user = config.preferences.user.name;
    myAliases = self.lib.mkShellAliases { inherit pkgs lib; };
  in {

    home-manager.users.${user} = {
      programs.nushell = {
        enable = true;
        shellAliases = myAliases;

        # From shells2/nushell.nix
        settings = {
          history.file_format = "sqlite";
          show_banner = false;
          edit_mode = "vi";
          rm.always_trash = true;

          cursor_shape = {
            vi_insert = "line";
            vi_normal = "block";
          };

          table = {
            trim = {
              methodology = "wrapping";
              wrapping_try_keep_words = true;
            };
            header_on_separator = true;
          };

          color_config = {
            shape_external = "green";
            shape_external_resolved = "green_bold";
            shape_internalcall = "green_bold";
            shape_garbage = "red";
          };
        };

        extraConfig = ''
          # lf wrapper
          def --env lf [...args] {
              let last_dir = (command lf -print-last-dir ...$args)
              if ($last_dir | is-not-empty) { cd $last_dir }
          }

          # Sparklines clear screen shortcut
          $env.config.keybindings ++= [
            {
              name: clear_screen_with_sparklines
              modifier: control
              keycode: char_l
              mode: [emacs, vi_normal, vi_insert]
              event: [
                { send: executehostcommand cmd: "clear --keep-scrollback; seq 1 (tput cols | into int) | shuffle | to text | ${lib.getExe pkgs.python3Packages.sparklines} | ${lib.getExe pkgs.lolcat}" }
              ]
            }
          ]

          # Setup multiple external completers (Carapace, Fish, Zoxide)
          let carapace_completer = {|spans: list<string>|
            carapace $spans.0 nushell ...$spans | from json | if ($in | default [] | where value == $"($spans | last)ERR" | is-empty) { $in } else { null }
          }

          let fish_completer = {|spans|
            ${lib.getExe pkgs.fish} --command $'complete "--do-complete=($spans | str join " ")"' | $"value(char tab)description(char newline)" + $in | from tsv --flexible --no-infer
          }

          let zoxide_completer = {|spans|
            $spans | skip 1 | zoxide query -l ...$in | lines | where {|x| $x != $env.PWD}
          }

          let multiple_completers = {|spans|
            match $spans.0 {
              __zoxide_z | __zoxide_zi | z | zi => $zoxide_completer
              nu => $fish_completer
              git => $fish_completer
              _ => $carapace_completer
            } | do $in $spans
          }
          $env.config.completions.external.completer = $multiple_completers;
        '';
      };
    };
  };
}
