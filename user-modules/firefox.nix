# Configuration for the Firefox browser
# https://mozilla.org/firefox
# Profile and policy settings selected with ffprofile
# https://github.com/allo-/ffprofile

# TODO: Implement Arkenfox configuration

{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;

    # Group policies to install
    # https://mozilla.github.io/policy-templates/
    policies = {
      # Sane defaults
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisableFirefoxAccounts = true;
      DisablePocket = true;
      NoDefaultBookmarks = true;

      NetworkPrediction = false;
      CaptivePortal = false;

      DontCheckDefaultBrowser = true;
      NewTabPage = true;
      SearchBar = "unified";

      Preferences = let
        true_default = { Value = true; Status = "default"; };
        false_locked = { Value = false; Status = "locked"; };
        nullstr_locked = { Value = ""; Status = "locked"; };
      in {
        "extensions.pocket.enabled" = false_locked;
        "browser.newtabpage.pinned" = nullstr_locked;
        "browser.topsites.contile.enabled" = false_locked;
        "browser.newtabpage.activity-stream.showSponsored" = false_locked;
        "browser.newtabpage.activity-stream.system.showSponsored" = false_locked;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false_locked;
        "browser.newtabpage.activity-stream.default.sites" = nullstr_locked;
        "privacy.userContext.enabled" = true_default;
        "privacy.userContext.ui.enabled" = true_default;
      };

      # List installed extensions for all profiles
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        # "Decentraleyes@ThomasRientjes" = {
        #   install_url = "https://addons.mozilla.org/firefox/downloads/latest/decentraleyes/latest.xpi";
        #   installation_mode = "normal_installed";
        # };
        # "CanvasBlocker@kkapsner.net" = {
        #   install_url = "https://addons.mozilla.org/firefox/downloads/latest/canvasblocker/latest.xpi";
        #   installation_mode = "normal_installed";
        # };
        # "addon@darkreader.org" = {
        #   install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
        #   installation_mode = "normal_installed";
        # };
        # "sponsorBlocker@ajay.app" = {
        #   install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
        #   installation_mode = "normal_installed";
        # };
      };
    };

    # Configure the main profile
    # See all avaliable options at:
    # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.firefox.enable
    profiles.main = {
      id = 0;
      isDefault = true;
      
      # TODO: Load bookmarks from sops-encrypted json backup
      # Load the bookmarks
      #bookmarks = (builtins.fromJSON (builtins.readFile ./main-bookmarks.json));
      bookmarks = {};

      # Install extensions per profile from Nix User Repositories (NUR)
      # https://nur.nix-community.org/
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        # ublock-origin    # Efficient wide-spectrum content blocker
        tridactyl        # Vim-like interface for Firefox
        decentraleyes    # Local content delivery network emulation
        canvasblocker    # Alters JS APIs to prevent fingerprinting
        sponsorblock     # Skip YouTube video sponsors
        darkreader       # Dark mode for every website
      ]

      # Set default search engine
      search = {
        force = true;
        default = "DuckDuckGo";
        privateDefault = "DuckDuckGo";
        order = [ "DuckDuckGo" ];
        engines = {
          "Google".metaData.hidden = true;
          "Bing".metaData.hidden = true;
        };
      };

      # Set a minimal style inspired by qutebrowser
      # https://github.com/rockofox/firefox-minima
      userChrome = ''
        @import "${
          builtins.fetchGit {
              url = "https://github.com/rockofox/firefox-minima";
              ref = "main";
              rev = "dc40a861b24b378982c265a7769e3228ffccd45a"; # Update commit hash
          }
        }/userChrome.css";
      '';

      # Configure profile settings
      settings = {
        "widget.use-xdg-desktop-portal.file-picker" = 1;
        "app.normandy.api_url" = "";
        "app.normandy.enabled" = false;
        "app.shield.optoutstudies.enabled" = false;
        "app.update.auto" = false;
        "beacon.enabled" = false;
        "breakpad.reportURL" = "";
        "browser.aboutConfig.showWarning" = false;
        "browser.cache.disk.enable" = false;
        "browser.cache.offline.enable" = false;
        "browser.crashReports.unsubmittedCheck.autoSubmit" = false;
        "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
        "browser.crashReports.unsubmittedCheck.enabled" = false;
        "browser.disableResetPrompt" = true;
        "browser.fixup.alternate.enabled" = false;
        "browser.newtab.preload" = false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
        "browser.newtabpage.enabled" = false;
        "browser.newtabpage.enhanced" = false;
        "browser.newtabpage.introShown" = true;
        "browser.safebrowsing.appRepURL" = "";
        "browser.safebrowsing.blockedURIs.enabled" = false;
        "browser.safebrowsing.downloads.enabled" = false;
        "browser.safebrowsing.downloads.remote.enabled" = false;
        "browser.safebrowsing.downloads.remote.url" = "";
        "browser.safebrowsing.enabled" = false;
        "browser.safebrowsing.malware.enabled" = false;
        "browser.safebrowsing.phishing.enabled" = false;
        "browser.search.suggest.enabled" = false;
        "browser.selfsupport.url" = "";
        "browser.send_pings" = false;
        "browser.sessionstore.privacy_level" = 0;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.startup.homepage_override.mstone" = "ignore";
        "browser.tabs.crashReporting.sendReport" = false;
        "browser.urlbar.groupLabels.enabled" = false;
        "browser.urlbar.quicksuggest.enabled" = false;
        "browser.urlbar.speculativeConnect.enabled" = false;
        "browser.urlbar.trimURLs" = false;
        "datareporting.healthreport.service.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "device.sensors.ambientLight.enabled" = false;
        "device.sensors.enabled" = false;
        "device.sensors.motion.enabled" = false;
        "device.sensors.orientation.enabled" = false;
        "device.sensors.proximity.enabled" = false;
        "dom.battery.enabled" = false;
        "dom.event.clipboardevents.enabled" = false;
        "dom.webaudio.enabled" = false;
        "experiments.activeExperiment" = false;
        "experiments.enabled" = false;
        "experiments.manifest.uri" = "";
        "experiments.supported" = false;
        "extensions.Decentraleyes@ThomasRientjes.whiteList" = "";
        "extensions.autoDisableScopes" = 14;
        "extensions.getAddons.cache.enabled" = false;
        "extensions.getAddons.showPane" = false;
        "extensions.greasemonkey.stats.optedin" = false;
        "extensions.greasemonkey.stats.url" = "";
        "extensions.pocket.enabled" = false;
        "extensions.shield-recipe-client.api_url" = "";
        "extensions.shield-recipe-client.enabled" = false;
        "extensions.webservice.discoverURL" = "";
        "general.useragent.override" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.3";
        "general.autoScroll" = true;
        "media.autoplay.default" = 1;
        "media.autoplay.enabled" = false;
        "media.eme.enabled" = false;
        "media.gmp-widevinecdm.enabled" = false;
        "media.navigator.enabled" = false;
        "media.peerconnection.enabled" = false;
        "media.video_stats.enabled" = false;
        "network.IDN_show_punycode" = true;
        "network.allow-experiments" = false;
        "network.captive-portal-service.enabled" = false;
        "network.cookie.cookieBehavior" = 1;
        "network.dns.disablePrefetch" = true;
        "network.dns.disablePrefetchFromHTTPS" = true;
        "network.http.referer.spoofSource" = true;
        "network.http.speculative-parallel-limit" = 0;
        "network.predictor.enable-prefetch" = false;
        "network.predictor.enabled" = false;
        "network.prefetch-next" = false;
        "network.trr.mode" = 5;
        "privacy.donottrackheader.enabled" = true;
        "privacy.donottrackheader.value" = 1;
        "privacy.query_stripping" = true;
        "privacy.trackingprotection.cryptomining.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;
        "privacy.trackingprotection.pbmode.enabled" = true;
        "privacy.usercontext.about_newtab_segregation.enabled" = true;
        "security.ssl.disable_session_identifiers" = true;
        "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSite" = false;
        "signon.autofillForms" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.cachedClientID" = "";
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.prompted" = 2;
        "toolkit.telemetry.rejected" = true;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.server" = "";
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.unifiedIsOptIn" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "webgl.disabled" = true;
        "webgl.renderer-string-override" = " ";
        "webgl.vendor-string-override" = " ";
      };

      # Force replace the existing containers configuration
      containersForce = true;

      # Set up tab containers
      containers = {};
    };

    # Configure the container profile
    profiles.container = {
      id = 1;

      # Load the bookmarks
      #bookmarks = (builtins.fromJSON (builtins.readFile ./container-bookmarks.json));
      bookmarks = {};

      # Set default search engine
      search.default = "DuckDuckGo";

      # Configure profile settings
      settings = {
        "privacy.donottrackheader.enabled" = true;
        "privacy.donottrackheader.value" = 1;
        "privacy.trackingprotection.cryptomining.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;
        "privacy.trackingprotection.pbmode.enabled" = true;
        "general.autoScroll" = true;
        "webgl.disabled" = false;
      };

      # Force replace the existing containers configuration
      containersForce = true;
      
      # Set up tab containers
      containers = {
        work = {
          color = "orange";
          icon = "circle";
          id = 1;
        };
      };
    };
  };
}
