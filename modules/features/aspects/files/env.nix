{ ... }:
{
  flake.nixosModules.env = { config, ... }:
  let
    user = config.preferences.user.name;
    appPrefs = config.preferences.apps;
    homeDir = config.home-manager.users.${user}.home.homeDirectory;

    dirs = {
      academic = "${homeDir}/academic";
      dev = "${homeDir}/dev";
      downloads = "${homeDir}/downloads";
      pendings = "${homeDir}/pendings";
      professional = "${homeDir}/professional";
      projects = "${homeDir}/projects";
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

      # Obsidian vaults
      vaultsSelf = "${dirs.vaults}/self";
      vaultsToDo = "${dirs.vaults}/ToDo";

      # User binaries
      userBinDocker = "${xdgDirs.binHome}/docker";
      userBinUtils = "${xdgDirs.binHome}/utils";
    };
  in
  {
    environment.variables = {
      EDITOR = appPrefs.editor;
      VISUAL = appPrefs.editor;
      SUDO_EDITOR = appPrefs.editor;
    };

    home-manager.users.${user} = {
      home.sessionVariables = {
        # App preferences from preferences.apps
        BROWSER = appPrefs.browser;
        EDITOR = appPrefs.editor;
        VISUAL = appPrefs.editor;
        SUDO_EDITOR = appPrefs.editor;
        TERMINAL = appPrefs.terminal;
        IMAGE_VIEWER = appPrefs.imageViewer;
        VIDEO_PLAYER = appPrefs.videoPlayer;
        AUDIO_PLAYER = appPrefs.audioPlayer;
        PDF_VIEWER = appPrefs.pdfViewer;
        WM = appPrefs.wm;
        PAGER = appPrefs.pager;
        MANPAGER = appPrefs.pager;

        # Main dirs
        HOME_ACADEMIC = dirs.academic;
        HOME_DOWNLOADS = dirs.downloads;
        HOME_PROJECTS = dirs.projects;
        HOME_PROFESSIONAL = dirs.professional;
        HOME_VAULTS = dirs.vaults;

        # Dev dirs
        DEV_UTILS = derivedDirs.devUtils;
        IRIX = derivedDirs.devIrix;

        # Vaults
        HOME_VAULTS_SELF = derivedDirs.vaultsSelf;
        HOME_VAULTS_TODO = derivedDirs.vaultsToDo;

        # Device mounts (reserved)
        MNT_A = "";
        MNT_B = "";
        MNT_C = "";

        # XDG
        XDG_BIN_HOME = xdgDirs.binHome;
        XDG_CONFIG_HOME = xdgDirs.configHome;
        XDG_CACHE_HOME = xdgDirs.cacheHome;
        XDG_SHARE_APPS = xdgDirs.shareApps;

        # User binary dirs
        USERBIN_DOCKER = derivedDirs.userBinDocker;
        USERBIN_UTILS = derivedDirs.userBinUtils;

        # App-specific histories
        HISTFILE = "${config.home-manager.users.${user}.xdg.cacheHome}/zsh/.zsh_history";
        NODE_REPL_HISTORY = "${config.home-manager.users.${user}.xdg.cacheHome}/node/.node_repl_history";
        PYTHON_HISTORY = "${config.home-manager.users.${user}.xdg.cacheHome}/python/.python_history";
        LESSHISTFILE = "/dev/null";
        KEYTIMEOUT = "1";
        MOZ_ENABLE_WAYLAND = "1";

        # External dotconfigs
        DOOMDIR = "${xdgDirs.configHome}/doom";
        DOTCONFIG_DOOM = "${xdgDirs.configHome}/doom";
      };

      home.sessionPath = [
        xdgDirs.binHome
        "${homeDir}/.config/emacs/bin"
      ];

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
  };
}
