{ lib, ... }:
{
  flake.nixosModules.env = { lib, config, ... }:
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

    fishHistoryFile = "${homeDir}/.local/share/fish/fish_history";
    mcflyHistoryDb = "${homeDir}/.local/share/mcfly/history.db";

    derivedDirs = {
      # Dev
      devIrix = "${dirs.dev}/irix";
      devUtils = "${dirs.dev}/utils";

      # Obsidian vaults
      vaultsSelf = "${dirs.vaults}/self";
      vaultsToDo = "${dirs.vaults}/ToDo";
      
      # Academic
      academicNotes = "${dirs.academic}/notes";
      university = "${dirs.academic}/university";
      docs = "${dirs.academic}/docs";

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

        # Academic dirs
        ACADEMIC_NOTES = derivedDirs.academicNotes;
        UNIVERSITY = derivedDirs.university;
        DOCS = derivedDirs.docs;
        
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
        HISTFILE = fishHistoryFile;
        MCFLY_HISTFILE = mcflyHistoryDb;

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

      # Ensure shell history + mcfly DB paths exist before shell startup
      systemd.user.tmpfiles.rules = [
        "d %h/.local/share/fish 0700 - - -"
        "f %h/.local/share/fish/fish_history 0600 - - -"
        "d %h/.local/share/mcfly 0700 - - -"
      ];

      xdg = {
        enable = true;
        userDirs = {
          enable = true;
          createDirectories = true;

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
