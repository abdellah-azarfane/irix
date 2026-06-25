{ lib, ... }:
{
  flake.nixosModules.env = { lib, config, ... }:
  let
    user = config.preferences.user.name;
    appPrefs = config.preferences.apps;
    homeDir = config.home-manager.users.${user}.home.homeDirectory;
    docsDir = "${homeDir}/documents";

    # Added lowercase pictures folder nested inside documents
    dirs = {
      academic     = "${docsDir}/academic";
      dev          = "${homeDir}/dev";
      downloads    = "${homeDir}/downloads";
      pendings     = "${homeDir}/pendings";
      pictures     = "${docsDir}/pictures"; # Force lowercase pictures
      professional = "${docsDir}/professional";
      projects     = "${docsDir}/projects";
      vaults       = "${docsDir}/vaults";
    };

    xdgDirs = {
      binHome    = "${homeDir}/.local/bin";
      configHome = "${homeDir}/.config";
      cacheHome  = "${homeDir}/.cache";
      shareApps  = "${homeDir}/.nix-profile/share/applications";
    };

    fishHistoryFile = "${homeDir}/.local/share/fish/fish_history";
    mcflyHistoryDb = "${homeDir}/.local/share/mcfly/history.db";

    derivedDirs = {
      devIrix       = "${dirs.dev}/irix";
      devUtils      = "${dirs.dev}/utils";
      vaultsSelf    = "${dirs.vaults}/self";
      vaultsToDo    = "${dirs.vaults}/todo";
      academicNotes = "${dirs.academic}/notes";
      university    = "${dirs.academic}/university";
      docs          = "${dirs.academic}/docs";
      userBinDocker = "${xdgDirs.binHome}/docker";
      userBinUtils  = "${xdgDirs.binHome}/utils";
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

        HOME_ACADEMIC = dirs.academic;
        HOME_DOWNLOADS = dirs.downloads;
        HOME_PICTURES = dirs.pictures; # Exposed environment variable
        HOME_PROJECTS = dirs.projects;
        HOME_PROFESSIONAL = dirs.professional;
        HOME_VAULTS = dirs.vaults;

        DEV_UTILS = derivedDirs.devUtils;
        IRIX = derivedDirs.devIrix;

        ACADEMIC_NOTES = derivedDirs.academicNotes;
        UNIVERSITY = derivedDirs.university;
        DOCS = derivedDirs.docs;

        HOME_VAULTS_SELF = derivedDirs.vaultsSelf;
        HOME_VAULTS_TODO = derivedDirs.vaultsToDo;

        MNT_A = "";
        MNT_B = "";
        MNT_C = "";

        XDG_BIN_HOME = xdgDirs.binHome;
        XDG_CONFIG_HOME = xdgDirs.configHome;
        XDG_CACHE_HOME = xdgDirs.cacheHome;
        XDG_SHARE_APPS = xdgDirs.shareApps;

        USERBIN_DOCKER = derivedDirs.userBinDocker;
        USERBIN_UTILS = derivedDirs.userBinUtils;

        HISTFILE = fishHistoryFile;
        MCFLY_HISTFILE = mcflyHistoryDb;

        NODE_REPL_HISTORY = "${config.home-manager.users.${user}.xdg.cacheHome}/node/.node_repl_history";
        PYTHON_HISTORY = "${config.home-manager.users.${user}.xdg.cacheHome}/python/.python_history";
        LESSHISTFILE = "/dev/null";
        KEYTIMEOUT = "1";
        MOZ_ENABLE_WAYLAND = "1";
      };

      home.sessionPath = [
        xdgDirs.binHome
        "${homeDir}/.config/emacs/bin"
      ];

      systemd.user.tmpfiles.rules = [
        "d ${docsDir} 0755 - - -"
        "d ${dirs.academic} 0755 - - -"
        "d ${derivedDirs.academicNotes} 0755 - - -"
        "d ${derivedDirs.university} 0755 - - -"
        "d ${derivedDirs.docs} 0755 - - -"

        "d ${dirs.dev} 0755 - - -"
        "d ${derivedDirs.devIrix} 0755 - - -"
        "d ${derivedDirs.devUtils} 0755 - - -"

        "d ${dirs.downloads} 0755 - - -"
        "d ${dirs.pendings} 0755 - - -"
        "d ${dirs.pictures} 0755 - - - " # Auto-creates the pictures folder
        "d ${dirs.professional} 0755 - - -"
        "d ${dirs.projects} 0755 - - -"
        "d ${dirs.vaults} 0755 - - -"
        "d ${derivedDirs.vaultsSelf} 0755 - - -"
        "d ${derivedDirs.vaultsToDo} 0755 - - -"

        "d ${xdgDirs.binHome} 0755 - - -"
        "d ${derivedDirs.userBinDocker} 0755 - - -"
        "d ${derivedDirs.userBinUtils} 0755 - - -"

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
          documents = docsDir;
          download = dirs.downloads;
          music = null;
          videos = null;
          pictures = dirs.pictures;
        };
      };
    };
  };
}
