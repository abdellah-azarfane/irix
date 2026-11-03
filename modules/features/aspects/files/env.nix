{ lib, ... }:
{
  flake.nixosModules.env =
    { lib, config, ... }:
    let
      user = config.preferences.user.name;
      appPrefs = config.preferences.apps;
      homeDir = config.home-manager.users.${user}.home.homeDirectory;
      docsDir = "${homeDir}/documents";
      devDir = "${homeDir}/dev";
      dataDir = "${homeDir}/data";

      # 1. Répertoires principaux
      dirs = {
        backups = "${homeDir}/backups";
        data = dataDir;
        dev = devDir;
        documents = docsDir;
        downloads = "${homeDir}/downloads";
        pendings = "${homeDir}/pendings";
      };

      # 2. Sous-architecture : Ingénierie, IA & Recherche (~/dev & ~/data)
      devDirs = {
        irix = "${devDir}/irix";
        ai = "${devDir}/ai"; # Agents, RAG, PyTorch/JAX, projets IIA
        projects = "${devDir}/projects"; # Side-projects logiciels
        research = "${devDir}/research"; # Code de recherche, algorithmes, simulations
        labs = "${devDir}/labs"; # Sandbox (remplace ~/dev/langs)
        utils = "${devDir}/utils";

        datasets = "${dataDir}/datasets"; # Datasets Data Science / SQL / CSV
        models = "${dataDir}/models"; # Poids LLM / GGUF / checkpoints
      };

      # 3. Sous-architecture : Académique, Emacs Org & Admin (~/documents)
      docDirs = {
        academic = "${docsDir}/academic";
        university = "${docsDir}/academic/university"; # Cours SMI/IIA
        acResearch = "${docsDir}/academic/research"; # Publications LaTeX / Typst
        library = "${docsDir}/academic/library"; # Livres PDF, Zotero & fichier .bib
        tcf = "${docsDir}/academic/tcf"; # Révisions TCF

        admin = "${docsDir}/admin"; # Relevés, Bac, Campus France, reçus
        professional = "${docsDir}/professional"; # CV, Tutorat, carrière

        org = "${docsDir}/org"; # Racine Emacs Org-mode
        orgRoam = "${docsDir}/org/roam"; # Zettelkasten (Maths, Info, IA)
        orgDaily = "${docsDir}/org/daily"; # Notes journalières
        orgProjects = "${docsDir}/org/projects"; # Gestion de tâches & projets

        pictures = "${docsDir}/pictures";
        screenshots = "${docsDir}/pictures/screenshots";
        wallpapers = "${docsDir}/pictures/wallpapers";
      };

      # 4. Répertoires XDG & Binaires locaux
      xdgDirs = {
        binHome = "${homeDir}/.local/bin";
        configHome = "${homeDir}/.config";
        cacheHome = "${homeDir}/.cache";
        dataHome = "${homeDir}/.local/share";
        shareApps = "${homeDir}/.nix-profile/share/applications";
        userBinDocker = "${homeDir}/.local/bin/docker";
        userBinUtils = "${homeDir}/.local/bin/utils";
      };

      fishHistoryFile = "${xdgDirs.dataHome}/fish/fish_history";
      mcflyHistoryDb = "${xdgDirs.dataHome}/mcfly/history.db";

      # Liste automatique de tous les dossiers à générer par systemd-tmpfiles
      allManagedDirs =
        (builtins.attrValues dirs)
        ++ (builtins.attrValues devDirs)
        ++ (builtins.attrValues docDirs)
        ++ [
          xdgDirs.binHome
          xdgDirs.userBinDocker
          xdgDirs.userBinUtils
        ];
    in
    {
      environment.variables = {
        EDITOR = appPrefs.editor;
        VISUAL = appPrefs.editor;
        SUDO_EDITOR = appPrefs.editor;
      };

      home-manager.users.${user} = {
        home.sessionVariables = {
          # Applications par défaut
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

          # Racines principales
          HOME_DEV = dirs.dev;
          HOME_DATA = dirs.data;
          HOME_DOCS = dirs.documents;
          HOME_DOWNLOADS = dirs.downloads;
          HOME_BACKUPS = dirs.backups;

          # Ingénierie & IA (Navigation rapide CLI / Scripts)
          IRIX = devDirs.irix;
          DEV_AI = devDirs.ai;
          DEV_PROJECTS = devDirs.projects;
          DEV_RESEARCH = devDirs.research;
          DEV_LABS = devDirs.labs;
          DEV_UTILS = devDirs.utils;
          DATA_SETS = devDirs.datasets;
          DATA_MODELS = devDirs.models;

          # Académique & Recherche (SMI / IIA)
          HOME_ACADEMIC = docDirs.academic;
          UNIVERSITY = docDirs.university;
          ACADEMIC_RESEARCH = docDirs.acResearch;
          ACADEMIC_LIBRARY = docDirs.library;
          BIB_LIBRARY = "${docDirs.library}/references.bib"; # Pour Emacs Citar / LaTeX / Typst
          ACADEMIC_TCF = docDirs.tcf;

          # Emacs Org-mode
          HOME_ORG = docDirs.org;
          HOME_ORG_ROAM = docDirs.orgRoam;
          HOME_ORG_DAILY = docDirs.orgDaily;
          HOME_ORG_PROJECTS = docDirs.orgProjects;

          # Vie Pro, Admin & Médias
          HOME_ADMIN = docDirs.admin;
          HOME_PROFESSIONAL = docDirs.professional;
          HOME_PICTURES = docDirs.pictures;
          HOME_SCREENSHOTS = docDirs.screenshots;
          HOME_WALLPAPERS = docDirs.wallpapers;

          # Standards XDG
          XDG_BIN_HOME = xdgDirs.binHome;
          XDG_CONFIG_HOME = xdgDirs.configHome;
          XDG_CACHE_HOME = xdgDirs.cacheHome;
          XDG_DATA_HOME = xdgDirs.dataHome;
          XDG_SHARE_APPS = xdgDirs.shareApps;

          USERBIN_DOCKER = xdgDirs.userBinDocker;
          USERBIN_UTILS = xdgDirs.userBinUtils;

          # Historiques & Outils de dev
          HISTFILE = fishHistoryFile;
          MCFLY_HISTFILE = mcflyHistoryDb;
          NODE_REPL_HISTORY = "${xdgDirs.cacheHome}/node/.node_repl_history";
          PYTHON_HISTORY = "${xdgDirs.cacheHome}/python/.python_history";
          PYTHONPYCACHEPREFIX = "${xdgDirs.cacheHome}/python/pycache"; # Évite les dossiers __pycache__ partout !
          CARGO_HOME = "${xdgDirs.dataHome}/cargo";
          RUSTUP_HOME = "${xdgDirs.dataHome}/rustup";
          LESSHISTFILE = "/dev/null";
          KEYTIMEOUT = "1";
          MOZ_ENABLE_WAYLAND = "1";
        };

        home.sessionPath = [
          xdgDirs.binHome
        ];

        # Création déclarative et automatique de toute l'arborescence
        systemd.user.tmpfiles.rules = (map (dir: "d ${dir} 0755 - - -") allManagedDirs) ++ [
          "d ${xdgDirs.dataHome}/fish 0700 - - -"
          "f ${fishHistoryFile} 0600 - - -"
          "d ${xdgDirs.dataHome}/mcfly 0700 - - -"
          "d ${xdgDirs.cacheHome}/python/pycache 0755 - - -"
        ];

        xdg = {
          enable = true;
          userDirs = {
            enable = true;
            createDirectories = true;
            publicShare = null;
            templates = null;
            desktop = null;
            documents = dirs.documents;
            download = dirs.downloads;
            music = null;
            videos = null;
            pictures = docDirs.pictures;
          };
        };
      };
    };
}
