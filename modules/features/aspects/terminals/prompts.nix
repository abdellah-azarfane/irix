{self, ...}: {
  flake.nixosModules.starship = {
    pkgs,
    config,
    ...
  }: let
    # Grab the global theme from your flake!
    theme = self.lib.theme;

    c = {
      # Normal (Mapped to Base16 Standard)
      color0 = theme.base00;
      color1 = theme.base08;
      color2 = theme.base0B;
      color3 = theme.base0A;
      color4 = theme.base0D;
      color5 = theme.base0E;
      color6 = theme.base0C;
      color7 = theme.base05;

      # Bright
      color8 = theme.base03;
      color9 = theme.base08;
      color10 = theme.base0B;
      color11 = theme.base0A;
      color12 = theme.base0D;
      color13 = theme.base0E;
      color14 = theme.base0C;
      color15 = theme.base07;

      # Extended
      color16 = theme.base09;
      color17 = theme.base0F;
      color18 = theme.base01;
      color19 = theme.base02;
      color20 = theme.base04;
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
  in {
    home-manager.users.${user} = {
      programs.starship = {
        enable = true;

        # Enables Starship integration for al shells
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
            style = "#6F685D"; # (You can change this to theme.base03 if you want!)
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
            style = "#928A7C";
          };

          directory = {
            fish_style_pwd_dir_length = 1;
            format = "[$path]($style) ";
            read_only = "⌽ ";
            style = "#4a7fff"; # (Consider changing to theme.base0D!)
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
            error_symbol = "[->>](${theme.base08})";
            success_symbol = "[->>](${theme.base03})";
            vimcmd_replace_one_symbol = "[<<-](${theme.base0E})";
            vimcmd_replace_symbol = "[<<-](${theme.base0E})";
            vimcmd_symbol = "[<<-](${theme.base0A})";
            vimcmd_visual_symbol = "[<<-](${theme.base0C})";
          };

          time = {
            format = "\\[[$time]($style)\\]";
            style = "#4B5F6F";
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
            style = "#462941";
            disabled = true;
          };
          docker_context = {
            symbol = "  ";
            format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
            style = "#462941";
            disabled = false;
          };
          kubernetes = {
            symbol = "󱃾 ";
            format = "[$symbol$context( \\($namespace\\))]($style) ";
            style = "cyan bold";
            disabled = false;
            detect_extensions = [];
            detect_files = ["k8s.yaml" "kubernetes.yaml" ".kubeconfig"];
            detect_folders = [".kube"];
            detect_env_vars = ["KUBECONFIG"];
          };
          vagrant = {
            symbol = " ";
            format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
            style = "#462941";
            disabled = true;
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
            style = "#462941";
            disabled = true;
          };
          opentofu = {
            symbol = "󱁢 ";
            format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
            style = "#462941";
            disabled = false;
          };

          # --- Custon-Langs
          custom = {
            clojure = {
              description = "Shows Clojure project";
              when = ''
                test -f project.clj || \
                test -f deps.edn || \
                test -f build.boot || \
                test -f shadow-cljs.edn || \
                test -f bb.edn
              '';
              command = ''
                if command -v clojure >/dev/null 2>&1; then
                  clojure -version 2>&1 | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+' | head -1
                else
                  echo "project"
                fi
              '';
              format = "${viaIcon} [ $output]($style) ";
              style = "bold green";
            };

            astro = {
              description = "Shows Astro project";
              when = ''
                test -f astro.config.mjs || \
                test -f astro.config.js || \
                test -f astro.config.ts || \
                find . -maxdepth 1 -name "*.astro" 2>/dev/null | grep -q .
              '';
              command = ''
                if [ -f package.json ] && grep -q '"astro"' package.json 2>/dev/null; then
                  grep '"astro":' package.json | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+' | head -1
                else
                  echo "project"
                fi
              '';
              format = "${viaIcon} [ $output]($style) ";
              style = "bold purple";
            };

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
              style = "bold blue";
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
              style = "bold red";
            };

            ada = {
              description = "Shows Ada project";
              when = ''
                test -f alire.toml || \
                test -f project.gpr || \
                find . -maxdepth 1 \( -name "*.ads" -o -name "*.adb" \) 2>/dev/null | grep -q .
              '';
              command = ''
                if command -v gnatmake >/dev/null 2>&1; then
                  gnatmake --version | head -1 | grep -o '[0-9]\+\.[0-9]\+'
                else
                  echo "project"
                fi
              '';
              format = "${viaIcon} [ $output]($style) ";
              style = "bold cyan";
            };

            agda = {
              description = "Shows Agda project";
              when = ''
                test -f .agda-lib || \
                find . -maxdepth 1 -name "*.agda" 2>/dev/null | grep -q .
              '';
              command = ''
                if command -v agda >/dev/null 2>&1; then
                  agda --version | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+' | head -1
                else
                  echo "project"
                fi
              '';
              format = "${viaIcon} [ $output]($style) ";
              style = "bold yellow";
            };

            angular = {
              description = "Shows Angular project";
              when = ''
                test -f angular.json || \
                test -f .angular-cli.json || \
                test -f angular-cli.json
              '';
              command = ''
                if [ -f package.json ] && grep -q '"@angular/core"' package.json 2>/dev/null; then
                  grep '"@angular/core":' package.json | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+' | head -1
                else
                  echo "project"
                fi
              '';
              format = "${viaIcon} [ $output]($style) ";
              style = "bold red";
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

          haskell = {
            format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
            style = "#9D72C0";
            disabled = false;
            symbol = " ";
            detect_extensions = ["hs" "cabal" "hs-boot"];
            detect_files = ["stack.yaml" "cabal.project" "package.yaml"];
            detect_folders = [];
          };
          haxe.disabled = true;
          helm.disabled = true;
          java.disabled = true;
          julia = {
            format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
            symbol = " ";
            style = "#C2736D";
            disabled = false;
            detect_extensions = ["jl"];
            detect_files = ["Project.toml" "Manifest.toml"];
            detect_folders = [];
          };
          kotlin.disabled = true;
          lua = {
            symbol = "󰢱 ";
            format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
            style = "#2D4F67";
            disabled = false;
            detect_extensions = ["lua"];
            detect_files = [".luarc.json" ".luacheckrc" "stylua.toml"];
            detect_folders = [];
          };
          meson.disabled = true;
          mise.disabled = true;
          mojo.disabled = true;
          nim.disabled = true;
          nodejs.disabled = false;
          ocaml = {
            format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
            symbol = " ";
            style = "#E6C384";
            disabled = false;
            detect_extensions = ["ml" "mli" "re" "rei"];
            detect_files = ["dune-project" "dune" "jbuild" ".merlin" "esy.lock"];
            detect_folders = [];
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
            style = "#c4b28a";
            disabled = false;
            python_binary = ["python3" "python"];
            detect_extensions = ["py"];
            detect_files = ["setup.py" "pyproject.toml" "requirements.txt" "__init__.py"];
            detect_folders = [];
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
          #  zsh_indicator = "󰬡 ";
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
          format =
            "${hostInfo}$line_break"
            + "${localInfo} $fill ${nixInfo}$line_break"
            + "${prompt}";
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
          git_commit = {tag_symbol = "◈";};
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
