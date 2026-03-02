{
  flake.modules.homeManager.terminals =
    { pkgs, ... }:
    {

      programs.tmux = {
        enable = true;
        mouse = true;
        clock24 = true;
        disableConfirmationPrompt = true;
        historyLimit = 10000;
        plugins = with pkgs; [
          tmuxPlugins.tmux-fzf
        ];
      };
    };
}
