{ ... }: {
  flake.nixosModules.starship =
    {
      pkgs,
      config,
      ...
    }:
    let
      c = {
        # Normal (Mapped to Base16 Standard)
        color0 = "color0";
        color1 = "color1";
        color2 = "color2";
        color3 = "color3";
        color4 = "color4";
        color5 = "color5";
        color6 = "color6";
        color7 = "color7";

        # Bright
        color8 = "color8";
        color9 = "color9";
        color10 = "color10";
        color11 = "color11";
        color12 = "color12";
        color13 = "color13";
        color14 = "color14";
        color15 = "color15";

        # Extended (Mapped back into the standard 16 slots)
        color16 = "color3"; # Fallback for base09 (Orange/Yellow)
        color17 = "color5"; # Fallback for base0F (Brown/Magenta)
        color18 = "color8"; # Fallback for base01 (Dark Grey)
        color19 = "color8"; # Fallback for base02
        color20 = "color7"; # Fallback for base04 (Dark Foreground)
      };

      i = {
        icon01 = "◆";
      };

      user = config.preferences.user.name;

      viaColor = c.color18;
      colors = c;
      viaIcon = "[${i.icon01}](${viaColor})";

      hostInfo = "$username$hostname($shlvl)($cmd_duration)(\${custom.times})";
      nixInfo = "($nix_shell)";
      localInfo = "$directory($git_branch$git_commit$git_state$git_status$git_metrics)$all";

      prompt = "$jobs$character";
    in
    {
      home-manager.users.${user} = {
        programs.starship = {
          enable = true;

          # Enables Starship integration for all shells
          enableNushellIntegration = true;
          enableBashIntegration = true;
          enableFishIntegration = true;

          settings = {
            # Global Settings
            scan_timeout = 100;
            command_timeout = 1000;

            # Custom Modules
            custom.times = {
              description = "Display Execution Times (Start and End Time)";
              command = "echo $STARSHIP_CUSTOM_START $STARSHIP_CUSTOM_END";
              format = "[$output]($style)";
              style = "${c.color8}"; # Replaced hardcoded #6F685D
              when = true;
            };

            # --- Main Modules ---
            username = {
              format = "[$user]($style)";
              show_always = true;
              style_user = "${colors.color19}";
            };

            hostname = {
              format = "[@$hostname]($style) ";
              style = "${colors.color18}";
              ssh_only = false;
              ssh_symbol = "󰒋 ";
            };

            shlvl = {
              disabled = false;
              format = "[$shlvl]($style) ";
              repeat = true;
              style = "${c.color20}";
              symbol = "T";
              threshold = 3;
            };

            cmd_duration = {
              format = "⑄ [$duration]($style) ";
              style = "${c.color8}"; # Replaced hardcoded #928A7C
            };

            directory = {
              fish_style_pwd_dir_length = 1;
              format = "[$path]($style) ";
              read_only = "⌽ ";
              style = "bold ${c.color4}"; # Replaced hardcoded #4a7fff
              truncate_to_repo = true;
              truncation_length = 3;
            };

            nix_shell = {
              format = "[($name <- )$symbol]($style) ";
              impure_msg = "impure";
              style = "${colors.color1}";
              symbol = " ";
              pure_msg = "pure";
              unknown_msg = "";
              disabled = false;
              heuristic = false;
            };

            character = {
              error_symbol = "[->>](${c.color1})"; # Replaced theme.base08
              success_symbol = "[->>](${c.color8})"; # Replaced theme.base03
              vimcmd_replace_one_symbol = "[<<-](${c.color5})"; # Replaced theme.base0E
              vimcmd_replace_symbol = "[<<-](${c.color5})"; # Replaced theme.base0E
              vimcmd_symbol = "[<<-](${c.color3})"; # Replaced theme.base0A
              vimcmd_visual_symbol = "[<<-](${c.color6})"; # Replaced theme.base0C
            };

            time = {
              format = "\\[[$time]($style)\\]";
              style = "${c.color8}"; # Replaced hardcoded #4B5F6F
              disabled = true;
            };

            aws = {
              disabled = false;
              symbol = " ";
              format = "[${i.icon01}](${viaColor}) [$symbol$profile(\\($region\\))]($style)";
            };

            gcloud = {
              disabled = true;
              format = "[${i.icon01}](${viaColor}) [$symbol$active(/$project)(\\($region\\))]($style)";
              symbol = "󱇶 ";
            };

            azure = {
              disabled = true;
              symbol = "󰠅 ";
            };

            openstack = {
              disabled = true;
              symbol = " ";
            };

            # --- Containerization & Virtualization ---
            container = {
              symbol = " ";
              format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
              style = "${c.color5}"; # Replaced hardcoded #462941
              disabled = true;
            };

            docker_context = {
              symbol = "  ";
              format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
              style = "${c.color5}"; # Replaced hardcoded #462941
              disabled = false;
            };

            kubernetes = {
              symbol = "󱃾 ";
              format = "[$symbol$context( \\($namespace\\))]($style) ";
              style = "${c.color6} bold"; # Replaced standard cyan
              disabled = false;
              detect_extensions = [ ];
              detect_files = [
                "k8s.yaml"
                "kubernetes.yaml"
                ".kubeconfig"
              ];
              detect_folders = [ ".kube" ];
              detect_env_vars = [ "KUBECONFIG" ];
            };

            vagrant = {
              symbol = " ";
              format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
              style = "${c.color5}"; # Replaced hardcoded #462941
              disabled = true;
            };

            # Optional custom module specifically for devenv
            custom.devenv = {
              command = "echo $DEVENV_ROOT | awk -F/ '{print $NF}'";
              when = "test -n \"$DEVENV_ROOT\"";
              format = "in [📦 $output]($style) ";
              style = "bold ${c.color3}"; # Replaced standard yellow
            };

            # --- File System & Package Management ---
            package = {
              symbol = "󰏗 ";
              disabled = false;
            };

            # --- Infrastructure & DevOps ---
            direnv = {
              symbol = " ";
              disabled = true;
            };

            pulumi = {
              symbol = " ";
              format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
              style = "${c.color5}"; # Replaced hardcoded #462941
              disabled = true;
            };

            # --- Custon-Langs ---
            custom = {
              typescript = {
                description = "Shows TypeScript project";
                when = ''
                  test -f tsconfig.json || \
                  test -f tsconfig.base.json || \
                  find . -maxdepth 1 -name "*.ts" -o -name "*.tsx" 2>/dev/null | grep -q .
                '';
                command = ''
                  if command -v tsc >/dev/null 2>&1; then
                    tsc --version | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+'
                  else
                    echo "project"
                  fi
                '';
                format = "${viaIcon} [ $output]($style) ";
                style = "bold ${c.color4}"; # Replaced standard blue
              };

              assembly = {
                description = "Shows Assembly project";
                when = ''
                  find . -maxdepth 1 \( -name "*.asm" -o -name "*.s" -o -name "*.S" \) 2>/dev/null | grep -q .
                '';
                command = ''
                  if command -v nasm >/dev/null 2>&1; then
                    echo "nasm"
                  elif command -v gas >/dev/null 2>&1; then
                    echo "gas"
                  else
                    echo "asm"
                  fi
                '';
                format = "${viaIcon} [ $output]($style) ";
                style = "bold ${c.color1}"; # Replaced standard red
              };
            };

            # --- Languages & Runtimes ---
            buf.disabled = true;
            bun.disabled = true;
            c.disabled = true;
            cmake.disabled = true;
            cobol.disabled = true;
            conda.disabled = false;
            crystal.disabled = true;
            daml.disabled = true;
            dart.disabled = true;
            deno.disabled = true;
            dotnet.disabled = true;
            elixir.disabled = false;
            elm.disabled = true;
            erlang.disabled = false;
            fennel.disabled = true;
            gleam.disabled = true;
            golang.disabled = false;
            gradle.disabled = true;
            guix_shell.disabled = true;
            haxe.disabled = true;
            helm.disabled = true;
            java.disabled = true;

            julia = {
              format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
              symbol = " ";
              style = "${c.color1}"; # Replaced hardcoded #C2736D
              disabled = false;
              detect_extensions = [ "jl" ];
              detect_files = [
                "Project.toml"
                "Manifest.toml"
              ];
              detect_folders = [ ];
            };

            kotlin.disabled = true;

            lua = {
              symbol = "󰢱 ";
              format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
              style = "${c.color4}"; # Replaced hardcoded #2D4F67
              disabled = false;
              detect_extensions = [ "lua" ];
              detect_files = [
                ".luarc.json"
                ".luacheckrc"
                "stylua.toml"
              ];
              detect_folders = [ ];
            };

            meson.disabled = true;
            mise.disabled = true;
            mojo.disabled = true;
            nim.disabled = true;
            nodejs.disabled = false;

            ocaml = {
              format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
              symbol = " ";
              style = "${c.color3}"; # Replaced hardcoded #E6C384
              disabled = false;
              detect_extensions = [
                "ml"
                "mli"
                "re"
                "rei"
              ];
              detect_files = [
                "dune-project"
                "dune"
                "jbuild"
                ".merlin"
                "esy.lock"
              ];
              detect_folders = [ ];
            };

            odin.disabled = false;
            opa.disabled = true;
            perl.disabled = true;
            php.disabled = true;
            pixi.disabled = true;
            purescript.disabled = true;

            python = {
              format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
              symbol = " ";
              style = "${c.color3}"; # Replaced hardcoded #c4b28a
              disabled = false;
              python_binary = [
                "python3"
                "python"
              ];
              detect_extensions = [ "py" ];
              detect_files = [
                "setup.py"
                "pyproject.toml"
                "requirements.txt"
                "__init__.py"
              ];
              detect_folders = [ ];
            };

            quarto.disabled = true;
            raku.disabled = true;
            red.disabled = true;
            rlang.disabled = false;
            ruby.disabled = true;
            rust.disabled = false;
            scala.disabled = false;
            solidity.disabled = true;
            swift.disabled = true;
            typst.disabled = false;
            vlang.disabled = true;
            zig.disabled = false;

            # --- Shells ---
            shell = {
              format = "[$indicator]($style) ";
              style = "white dimmed";
              disabled = true;
              fish_indicator = "󰈺 ";
              nu_indicator = "󰿈 ";
            };

            # --- System & Environment ---
            battery.disabled = true;
            jobs.symbol = "⛭ ";
            memory_usage.symbol = "󰍛 ";

            status = {
              symbol = "⨯";
              success_symbol = "✓";
              not_executable_symbol = "⊘";
              not_found_symbol = "?";
              sigint_symbol = "⊗";
              signal_symbol = "∿";
            };
            sudo.symbol = "♰";

            # --- Format ---
            format = "${hostInfo}$line_break" + "${localInfo} $fill ${nixInfo}$line_break" + "${prompt}";
            fill.symbol = " ";

            # --- Version Control ---
            git_branch = {
              disabled = false;
              format = "([${i.icon01}](${viaColor}) [$symbol$branch]($style) )";
              style = "${c.color8}";
              symbol = " ";
            };
            git_state = {
              am = "✉";
              am_or_rebase = "⟳";
              bisect = "⊟";
              cherry_pick = "⊚";
              merge = "∩";
              rebase = "↻";
              revert = "↺";
            };
            git_status = {
              format = "([\\[$all_status$ahead_behind\\]]($style) )";
              style = "${colors.color1}";
              ahead = "⇡";
              behind = "⇣";
              conflicted = "≠";
              deleted = "⨯";
              diverged = "⫩";
              modified = "◌";
              renamed = "↪";
              staged = "+";
              stashed = "‡";
              typechanged = "⊙";
              untracked = "?";
              up_to_date = "♦";
            };
            git_commit = {
              tag_symbol = "◈";
            };
            git_metrics = {
              disabled = false;
              added_style = "${colors.color13}";
              deleted_style = "${colors.color13}";
              format = "([\\[[$added]($added_style) ± [$deleted]($deleted_style)\\]]($added_style) )";
            };
          };
        };
      };
    };
}
