{
  flake.modules.homeManager.social =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        weechat # Extensible IRC/chat client
        discordo
        vesktop # NOTE: We use another client that has better Wayland support
        tut # Mastodon TUI client
        element-call
        element-desktop
        signal-desktop
        telegram-desktop
      ];
    };
}
