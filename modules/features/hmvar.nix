{
  flake.modules.homeManager.hmv =
    {
      config,
      ...
    }:
    let
      homeDir = config.home.homeDirectory;

      dirs = {
        academic = "${homeDir}/academic";
        dev = "${homeDir}/dev";
        downloads = "${homeDir}/downloads";
        konku = "${homeDir}/pendings/konku";
        professional = "${homeDir}/professional";
        vaults = "${homeDir}/vaults";
      };

      xdgDirs = {
        binHome = "${homeDir}/.local/bin";
        configHome = "${homeDir}/.config";
        cacheHome = "${homeDir}/.cache";
        shareApps = "${homeDir}/.nix-profile/share/applications";
      };

      derivedDirs = {
        # Dev
        devIrix = "${dirs.dev}/irix";
        devUtils = "${dirs.dev}/utils";

        # Obsidian Vault
        vaultsLights = "${dirs.vaults}/lights";
        vaultsNotices = "${dirs.vaults}/notices";

        # User binaries
        userBinFuzzel = "${xdgDirs.binHome}/fuzzel";
      };
    in
    {
      home.sessionVariables = {
        # App Preferences
        BROWSER = "brave";
        EDITOR = "nvim";
        VISUAL = "nvim";
        SUDO_EDITOR = "nvim";
        TERMINAL = "wezterm";
        IMAGE_VIEWER = "imv";
        VIDEO_PLAYER = "mpv";
        AUDIO_PLAYER = "mpv";
        PDF_VIEWER = "org.pwmt.zathura";
        WM = "niri";
        PAGER = "most";
        MANPAGER = "most";

        # Main dirs
        HOME_ACADEMIC = dirs.academic;
        HOME_DOWNLOADS = dirs.downloads;
        HOME_PROFESSIONAL = dirs.professional;
        HOME_VAULTS = dirs.vaults;

        # Dev
        DEV_UTILS = derivedDirs.devUtils;
        IRIX = derivedDirs.devIrix;
        # Vaults
        HOME_VAULTS_LIGHTS = derivedDirs.vaultsLights;
        HOME_VAULTS_NOTICES = derivedDirs.vaultsNotices;

        # Device mounts (TODO: Configure)
        MNT_A = "";
        MNT_B = "";
        MNT_C = "";

        # XDG Base Directory Specification
        XDG_BIN_HOME = xdgDirs.binHome;
        XDG_CONFIG_HOME = xdgDirs.configHome;
        XDG_CACHE_HOME = xdgDirs.cacheHome;
        XDG_SHARE_APPS = xdgDirs.shareApps;

        # User binaries
        USERBIN_FUZZEL = derivedDirs.userBinFuzzel;

        # App-specific
        HISTFILE = "${config.xdg.cacheHome}/zsh/.zsh_history";
        NODE_REPL_HISTORY = "${config.xdg.cacheHome}/node/.node_repl_history";
        PYTHON_HISTORY = "${config.xdg.cacheHome}/python/.python_history";
        LESSHISTFILE = "/dev/null";
        KEYTIMEOUT = "1";
        MOZ_ENABLE_WAYLAND = "1";

        # Special Dotconfigs
        # NOTE:
        # - Here we include dotconfigs
        #   that are not managed declaratively through NixOS
        # - A good example is Doom Emacs
        DOOMDIR = "${xdgDirs.configHome}/doom";
      };

      # Add directories to user's PATH
      home.sessionPath = [
        xdgDirs.binHome
        "${homeDir}/.config/emacs/bin"
      ];

      # Set xdg custom dirs for userDirs
      xdg = {
        enable = true;
        userDirs = {
          enable = true;
          createDirectories = false;

          publicShare = null;
          templates = null;
          desktop = null;
          documents = null;
          download = dirs.downloads;
          music = null;
          videos = null;
          pictures = null;
        };
      };
    };
}
