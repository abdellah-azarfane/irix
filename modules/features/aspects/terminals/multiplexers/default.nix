{
  flake.nixosModules.multiplexers = 
    {  pkgs, config, ...}: {
      environment.systemPackages = [pkgs.zellij];
      programs.tmux = {
        enable = true;
        clock24 = true;
        historyLimit = 10000;
        plugins = with pkgs.tmuxPlugins; [tmux-fzf];

        # Native tmux configuration text
        extraConfig = ''
          set -g mouse on
          set-option -g focus-events on
          bind-key x kill-pane
          bind-key & kill-window
        '';
      };
    };
}
