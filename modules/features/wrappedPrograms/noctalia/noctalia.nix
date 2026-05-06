{ inputs, ... }:
{
  perSystem =
    { pkgs, config, ... }:
    {
      packages = {
        noctalia-shell = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
          inherit pkgs;
          package = pkgs.noctalia-shell.overrideAttrs {
            name = "noctaliav2";
          };
          env = {
            "NOCTALIA_CACHE_DIR" = "/tmp/noctaliav2-cache/";
          };
          colors = {
            /*
              mError = "#fb4934";
              mHover = "#83a598";
              mOnError = "#282828";
              mOnHover = "#282828";
              mOnPrimary = "#282828";
              mOnSecondary = "#282828";
              mOnSurface = "#fbf1c7";
              mOnSurfaceVariant = "#ebdbb2";
              mOnTertiary = "#282828";
              mOutline = "#57514e";
              mPrimary = "#b8bb26";
              mSecondary = "#fabd2f";
              mShadow = "#282828";
              mSurface = "#282828";
              mSurfaceVariant = "#3c3836";
              mTertiary = "#83a598";
            */
          };
          settings = {
            settingsVersion = 59;  # NEW: updated to latest upstream schema

            bar = {
              # barType = "simple";  # NEW
              position = "left";
              monitors = [ ];
              density = "comfortable";
              showOutline = false;
              showCapsule = false;
              capsuleOpacity = 1;
              # capsuleColorKey = "none";  # NEW
              # widgetSpacing = 6;  # NEW
              # contentPadding = 2;  # NEW
              # fontScale = 1;  # NEW
              # enableExclusionZoneInset = true;  # NEW
              # backgroundOpacity = 0.93;  # NEW
              # useSeparateOpacity = false;  # NEW
              marginVertical = 0.25;
              marginHorizontal = 0.25;
              # frameThickness = 8;  # NEW
              # frameRadius = 12;  # NEW
              outerCorners = true;
              # hideOnOverview = false;  # NEW
              # displayMode = "always_visible";  # NEW
              # autoHideDelay = 500;  # NEW
              # autoShowDelay = 150;  # NEW
              # showOnWorkspaceSwitch = true;  # NEW
              widgets = {
                center = [ ];
                left = [
                  {
                    colorizeDistroLogo = true;
                    colorizeSystemIcon = "tertiary";
                    customIconPath = "";
                    enableColorization = true;
                    id = "ControlCenter";
                    useDistroLogo = true;
                  }
                  {
                    characterCount = 2;
                    colorizeIcons = false;
                    enableScrollWheel = true;
                    followFocusedScreen = false;
                    hideUnoccupied = true;
                    id = "Workspace";
                    labelMode = "none";
                    showApplications = false;
                    showLabelsOnlyWhenOccupied = true;
                  }
                ];
                right = [
                  {
                    hideWhenZero = false;
                    id = "NotificationHistory";
                    showUnreadBadge = true;
                  }
                  {
                    id = "PowerProfile";
                  }
                  {
                    displayMode = "alwaysHide";
                    id = "Volume";
                  }
                  {
                    deviceNativePath = "";
                    displayMode = "alwaysShow";
                    hideIfNotDetected = true;
                    id = "Battery";
                    showNoctaliaPerformance = false;
                    showPowerProfiles = false;
                    warningThreshold = 20;
                  }
                  {
                    displayMode = "alwaysHide";
                    id = "Microphone";
                  }
                  {
                    displayMode = "forceOpen";
                    id = "KeyboardLayout";
                  }
                  {
                    customFont = "";
                    formatHorizontal = "HH:mm ddd, MMM dd";
                    formatVertical = "HH mm - dd MM";
                    id = "Clock";
                    useCustomFont = false;
                    usePrimaryColor = true;
                  }
                  {
                    blacklist = [ ];
                    colorizeIcons = false;
                    drawerEnabled = true;
                    hidePassive = false;
                    id = "Tray";
                    pinned = [ ];
                  }
                ];
              };
              # mouseWheelAction = "none";  # NEW
              # reverseScroll = false;  # NEW
              # mouseWheelWrap = true;  # NEW
              # middleClickAction = "none";  # NEW
              # middleClickFollowMouse = false;  # NEW
              # middleClickCommand = "";  # NEW
              # rightClickAction = "controlCenter";  # NEW
              # rightClickFollowMouse = true;  # NEW
              # rightClickCommand = "";  # NEW
              # screenOverrides = [ ];  # NEW
              # Legacy keys retained for compatibility with existing setup.
              exclusive = true;
              floating = false;
              transparent = true;
            };

            general = {
              avatarImage = "/home/abosafiya/.cache/irix/current-wallpaper";
              dimmerOpacity = 0.15;
              showScreenCorners = false;
              forceBlackScreenCorners = false;
              scaleRatio = 1;
              radiusRatio = 1;
              iRadiusRatio = 1;
              boxRadiusRatio = 1;
              screenRadiusRatio = 1;
              animationSpeed = 1;
              animationDisabled = false;
              compactLockScreen = false;
              # lockScreenAnimations = false;  # NEW
              lockOnSuspend = true;
              showSessionButtonsOnLockScreen = true;
              showHibernateOnLockScreen = false;
              # enableLockScreenMediaControls = false;  # NEW
              enableShadows = true;
              # enableBlurBehind = true;  # NEW (renamed from enableBlur in upstream)
              shadowDirection = "bottom_right";
              shadowOffsetX = 2;
              shadowOffsetY = 3;
              language = "";
              allowPanelsOnScreenWithoutBar = true;
              # showChangelogOnStartup = true;  # NEW
              # telemetryEnabled = false;  # NEW
              # enableLockScreenCountdown = true;  # NEW
              # lockScreenCountdownDuration = 10000;  # NEW
              # autoStartAuth = false;  # NEW
              # allowPasswordWithFprintd = false;  # NEW
              # clockStyle = "custom";  # NEW
              # clockFormat = "hh\nmm";  # NEW
              # passwordChars = false;  # NEW
              # lockScreenMonitors = [ ];  # NEW
              # lockScreenBlur = 0;  # NEW
              # lockScreenTint = 0;  # NEW
              # keybinds = {  # NEW
              #   keyUp = [ "Up" ];
              #   keyDown = [ "Down" ];
              #   keyLeft = [ "Left" ];
              #   keyRight = [ "Right" ];
              #   keyEnter = [
              #     "Return"
              #     "Enter"
              #   ];
              #   keyEscape = [ "Esc" ];
              #   keyRemove = [ "Del" ];
              # };
              # reverseScroll = false;  # NEW
              # smoothScrollEnabled = true;  # NEW
              # Legacy keys retained for compatibility with existing setup.
              enableBlur = true;
              blurSigma = 50;
            };

            ui = {
              fontDefault = "Sans Serif";
              fontFixed = "monospace";
              fontDefaultScale = 1;
              fontFixedScale = 1;
              tooltipsEnabled = true;
              # scrollbarAlwaysVisible = true;  # NEW
              # boxBorderEnabled = false;  # NEW
              panelBackgroundOpacity = 0.9;
              # translucentWidgets = false;  # NEW
              panelsAttachedToBar = true;
              settingsPanelMode = "attached";
              # settingsPanelSideBarCardStyle = false;  # NEW
            };

            location = {
              # name = "";  # NEW
              weatherEnabled = true;
              weatherShowEffects = true;
              # weatherTaliaMascotAlways = false;  # NEW
              useFahrenheit = false;
              use12hourFormat = false;
              showWeekNumberInCalendar = false;
              showCalendarEvents = true;
              showCalendarWeather = true;
              analogClockInCalendar = false;
              firstDayOfWeek = -1;
              # hideWeatherTimezone = false;  # NEW
              # hideWeatherCityName = false;  # NEW
              # autoLocate = true;  # NEW
            };

            calendar = {
              cards = [
                {
                  enabled = true;
                  id = "calendar-header-card";
                }
                {
                  enabled = true;
                  id = "calendar-month-card";
                }
                {
                  enabled = true;
                  id = "timer-card";
                }
                {
                  enabled = true;
                  id = "weather-card";
                }
              ];
            };

            wallpaper = {
              enabled = true;
              overviewEnabled = true;
              directory = "/home/abosafiya/wallpapers";
              monitorDirectories = [ ];
              enableMultiMonitorDirectories = true;
              showHiddenFiles = false;
              viewMode = "single";
              setWallpaperOnAllMonitors = true;
              linkLightAndDarkWallpapers = true;
              fillMode = "crop";
              fillColor = "#000000";
              useSolidColor = false;
              solidColor = "#1a1a2e";
              automationEnabled = false;
              wallpaperChangeMode = "random";
              randomIntervalSec = 300;
              transitionDuration = 1500;
              transitionType = [
                "fade"
                "disc"
                "stripes"
                "wipe"
                "pixelate"
                "honeycomb"
              ];
              skipStartupTransition = false;
              transitionEdgeSmoothness = 0.05;
              panelPosition = "follow_bar";
              hideWallpaperFilenames = false;
              useOriginalImages = false;
              overviewBlur = 0.4;
              overviewTint = 0.6;
              useWallhaven = false;
              wallhavenQuery = "";
              wallhavenSorting = "relevance";
              wallhavenOrder = "desc";
              wallhavenCategories = "111";
              wallhavenPurity = "100";
              wallhavenRatios = "";
              wallhavenApiKey = "";
              wallhavenResolutionMode = "atleast";
              wallhavenResolutionWidth = "";
              wallhavenResolutionHeight = "";
              sortOrder = "name";
              favorites = [ ];
            };

            appLauncher = {
              enableClipboardHistory = false;
              # autoPasteClipboard = false;  # NEW
              enableClipPreview = true;
              # clipboardWrapText = true;  # NEW
              # enableClipboardSmartIcons = true;  # NEW
              # enableClipboardChips = true;  # NEW
              # clipboardWatchTextCommand = "wl-paste --type text --watch cliphist store";  # NEW
              # clipboardWatchImageCommand = "wl-paste --type image --watch cliphist store";  # NEW
              position = "center";
              pinnedApps = [ ];
              sortByMostUsed = true;
              terminalCommand = "kitty -e";
              customLaunchPrefixEnabled = false;
              customLaunchPrefix = "";
              viewMode = "list";
              showCategories = true;
              iconMode = "tabler";
              # showIconBackground = false;  # NEW
              # enableSettingsSearch = true;  # NEW
              # enableWindowsSearch = true;  # NEW
              # enableSessionSearch = true;  # NEW
              # ignoreMouseInput = false;  # NEW
              # screenshotAnnotationTool = "";  # NEW
              # overviewLayer = false;  # NEW
              # density = "default";  # NEW
              # Legacy keys retained for compatibility with existing setup.
              pinnedExecs = [ ];
              useApp2Unit = false;
            };

            controlCenter = {
              position = "close_to_bar_button";
              # diskPath = "/";  # NEW
              shortcuts = {
                left = [
                  { id = "WiFi"; }
                  { id = "Bluetooth"; }
                  { id = "ScreenRecorder"; }
                ];
                right = [
                  { id = "Notifications"; }
                  { id = "PowerProfile"; }
                ];
              };
              cards = [
                {
                  enabled = true;
                  id = "profile-card";
                }
                {
                  enabled = true;
                  id = "shortcuts-card";
                }
                {
                  enabled = true;
                  id = "audio-card";
                }
                {
                  enabled = true;
                  id = "brightness-card";
                }
                {
                  enabled = true;
                  id = "weather-card";
                }
                {
                  enabled = true;
                  id = "media-sysmon-card";
                }
              ];
            };

            systemMonitor = {
              cpuWarningThreshold = 80;
              cpuCriticalThreshold = 90;
              tempWarningThreshold = 80;
              tempCriticalThreshold = 90;
              gpuWarningThreshold = 80;
              gpuCriticalThreshold = 90;
              memWarningThreshold = 80;
              memCriticalThreshold = 90;
              # swapWarningThreshold = 80;  # NEW
              # swapCriticalThreshold = 90;  # NEW
              diskWarningThreshold = 80;
              diskCriticalThreshold = 90;
              # diskAvailWarningThreshold = 20;  # NEW
              # diskAvailCriticalThreshold = 10;  # NEW
              # batteryWarningThreshold = 20;  # NEW
              # batteryCriticalThreshold = 5;  # NEW
              enableDgpuMonitoring = false;
              useCustomColors = false;
              warningColor = "";
              criticalColor = "";
              # externalMonitor = "resources || missioncenter || jdsystemmonitor || corestats || system-monitoring-center || gnome-system-monitor || plasma-systemmonitor || mate-system-monitor || ukui-system-monitor || deepin-system-monitor || pantheon-system-monitor";  # NEW
              # Legacy keys retained for compatibility with existing setup.
              cpuPollingInterval = 3000;
              gpuPollingInterval = 3000;
              memPollingInterval = 3000;
              networkPollingInterval = 3000;
              tempPollingInterval = 3000;
              diskPollingInterval = 3000;
            };

            # noctaliaPerformance = {  # NEW SECTION
            #   disableWallpaper = true;
            #   disableDesktopWidgets = true;
            # };

            dock = {
              enabled = false;
              position = "bottom";
              displayMode = "auto_hide";
              # dockType = "floating";  # NEW
              backgroundOpacity = 1;
              floatingRatio = 1;
              size = 1;
              onlySameOutput = true;
              monitors = [ ];
              pinnedApps = [ ];
              colorizeIcons = false;
              # showLauncherIcon = false;  # NEW
              # launcherPosition = "end";  # NEW
              # launcherUseDistroLogo = false;  # NEW
              # launcherIcon = "";  # NEW
              # launcherIconColor = "none";  # NEW
              pinnedStatic = false;
              inactiveIndicators = false;
              # groupApps = false;  # NEW
              # groupContextMenuMode = "extended";  # NEW
              # groupClickAction = "cycle";  # NEW
              # groupIndicatorStyle = "dots";  # NEW
              deadOpacity = 0.6;
              animationSpeed = 2;
              # sitOnFrame = false;  # NEW
              # showDockIndicator = false;  # NEW
              # indicatorThickness = 3;  # NEW
              # indicatorColor = "primary";  # NEW
              # indicatorOpacity = 0.6;  # NEW
            };

            network = {
              # bluetoothRssiPollingEnabled = false;  # NEW
              # bluetoothRssiPollIntervalMs = 60000;  # NEW
              # networkPanelView = "wifi";  # NEW
              # wifiDetailsViewMode = "grid";  # NEW
              # bluetoothDetailsViewMode = "grid";  # NEW
              # bluetoothHideUnnamedDevices = false;  # NEW
              # disableDiscoverability = false;  # NEW
              # bluetoothAutoConnect = true;  # NEW
              # Legacy key retained for compatibility with existing setup.
              wifiEnabled = true;
            };

            sessionMenu = {
              enableCountdown = true;
              countdownDuration = 10000;
              position = "center";
              showHeader = true;
              # showKeybinds = true;  # NEW
              largeButtonsStyle = false;
              # largeButtonsLayout = "single-row";  # NEW
              powerOptions = [
                {
                  action = "lock";
                  command = "";
                  countdownEnabled = true;
                  enabled = true;
                  keybind = "1";
                }
                {
                  action = "suspend";
                  command = "";
                  countdownEnabled = true;
                  enabled = true;
                  keybind = "2";
                }
                {
                  action = "hibernate";
                  command = "";
                  countdownEnabled = true;
                  enabled = true;
                  keybind = "3";
                }
                {
                  action = "reboot";
                  command = "";
                  countdownEnabled = true;
                  enabled = true;
                  keybind = "4";
                }
                {
                  action = "logout";
                  command = "";
                  countdownEnabled = true;
                  enabled = true;
                  keybind = "5";
                }
                {
                  action = "shutdown";
                  command = "";
                  countdownEnabled = true;
                  enabled = true;
                  keybind = "6";
                }
                # {
                #   action = "rebootToUefi";  # NEW
                #   enabled = true;
                #   keybind = "7";  # NEW
                # }
              ];
            };

            notifications = {
              enabled = true;
              # enableMarkdown = false;  # NEW
              # density = "default";  # NEW
              monitors = [ ];
              location = "top_right";
              overlayLayer = true;
              backgroundOpacity = 0.9;
              respectExpireTimeout = false;
              lowUrgencyDuration = 8;
              normalUrgencyDuration = 8;
              criticalUrgencyDuration = 15;
              # clearDismissed = true;  # NEW
              # saveToHistory = {  # NEW
              #   low = true;
              #   normal = true;
              #   critical = true;
              # };
              sounds = {
                enabled = false;
                volume = 0.5;
                separateSounds = false;
                criticalSoundFile = "";
                normalSoundFile = "";
                lowSoundFile = "";
                excludedApps = "discord,firefox,chrome,chromium,edge";
              };
              enableMediaToast = false;
              enableKeyboardLayoutToast = true;
              enableBatteryToast = true;
            };

            osd = {
              enabled = true;
              location = "bottom";
              autoHideMs = 3000;
              overlayLayer = true;
              backgroundOpacity = 0.9;
              # enabledTypes = [  # NEW
              #   0
              #   1
              #   2
              #   4
              # ];
              monitors = [ ];
            };

            audio = {
              volumeStep = 5;
              volumeOverdrive = false;
              # spectrumFrameRate = 30;  # NEW (renamed from cavaFrameRate)
              visualizerType = "linear";
              # spectrumMirrored = true;  # NEW
              mprisBlacklist = [ ];
              preferredPlayer = "";
              # volumeFeedback = false;  # NEW
              # volumeFeedbackSoundFile = "";  # NEW
              # Legacy key retained for compatibility with existing setup.
              externalMixer = "pwvucontrol || pavucontrol";
            };

            brightness = {
              brightnessStep = 5;
              enforceMinimum = true;
              enableDdcSupport = false;
              # backlightDeviceMappings = [ ];  # NEW
            };

            colorSchemes = {
              useWallpaperColors = false;
              predefinedScheme = "Noctalia (default)";
              darkMode = true;
              schedulingMode = "off";
              manualSunrise = "06:30";
              manualSunset = "18:30";
              generationMethod = "tonal-spot";  # NEW
              monitorForColors = "";  # NEW
              syncGsettings = true;  # NEW
            };

            templates = {
              activeTemplates = [ ];  # NEW (migrated from individual booleans)
              enableUserTheming = false;  # NEW
              # Legacy key retained for compatibility with existing setup.
              # enableUserTemplates = false;  # Deprecated
            };

            nightLight = {
              enabled = false;
              forced = false;
              autoSchedule = true;
              nightTemp = "4000";
              dayTemp = "6500";
              manualSunrise = "06:30";
              manualSunset = "18:30";
            };

            hooks = {
              enabled = false;
              wallpaperChange = "";
              darkModeChange = "";
              screenLock = "";
              screenUnlock = "";
              performanceModeEnabled = "";
              performanceModeDisabled = "";
              startup = "";
              session = "";
              colorGeneration = "";
            };

            # plugins = {  # NEW SECTION
            #   autoUpdate = false;
            #   notifyUpdates = true;
            # };

            # idle = {  # NEW SECTION
            #   enabled = false;
            #   screenOffTimeout = 600;
            #   lockTimeout = 660;
            #   suspendTimeout = 1800;
            #   fadeDuration = 5;
            #   screenOffCommand = "";
            #   lockCommand = "";
            #   suspendCommand = "";
            #   resumeScreenOffCommand = "";
            #   resumeLockCommand = "";
            #   resumeSuspendCommand = "";
            #   customCommands = "[]";
            # };

            desktopWidgets = {
              enabled = false;
              overviewEnabled = true;
              gridSnap = false;
              # gridSnapScale = false;  # NEW
              monitorWidgets = [
                {
                  name = "HDMI-A-1";
                  widgets = [
                    {
                      hideMode = "visible";
                      id = "MediaPlayer";
                      showBackground = true;
                      showButtons = true;
                      visualizerType = "linear";
                      x = 100;
                      y = 200;
                    }
                  ];
                }
              ];
            };

            # Non-default section retained from your existing setup.
            screenRecorder = {
              audioCodec = "opus";
              audioSource = "default_output";
              colorRange = "limited";
              directory = "/home/abosafiya/videos";
              frameRate = 60;
              quality = "very_high";
              showCursor = true;
              videoCodec = "h264";
              videoSource = "portal";
            };
          };
        };
      };
    };
}
