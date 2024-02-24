{
  pkgs,
  user,
  ...
}: {
  home = {
    packages = with pkgs; [
      brave
    ];
  };
  programs = {
    firefox = {
      enable = true;
      package = pkgs.wrapFirefox pkgs.firefox-esr-115-unwrapped {
        extraPolicies = {
          DisableFirefoxStudies = true;
          DisablePocket = true;
          DisableTelemetry = true;
          DisableFirefoxAccounts = false;
          NoDefaultBookmarks = true;
          OfferToSaveLogins = false;
          OfferToSaveLoginsDefault = false;
          PasswordManagerEnabled = false;
          SanitizeOnShutdown = {
            Cache = false;
            Cookies = false;
            Downloads = true;
            FormData = true;
            History = true;
            Sessions = true;
            SiteSettings = true;
            OfflineApps = true;
            Locked = true;
          };
          SearchEngines = {
            PreventInstalls = true;
            Add = [
              {
                Name = "NixOS Search";
                Alias = "nix";
                Method = "GET";
                Description = "Search NixOS packages";
                PostData = "";
                URLTemplate = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}";
              }
            ];
          };
          FirefoxHome = {
            Search = true;
            Pocket = false;
            Snippets = false;
            TopSites = false;
            Highlights = false;
          };
          Preferences = {
            browser.theme.content-theme = "dark";
            extensions.activeThemeID = "firefox-compact-dark@mozilla.org";
          };
        };
      };
      profiles = {
        ${user} = {
          id = 0;
          name = "${user}";
          extensions = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            bitwarden
            privacy-badger
            clearurls
            decentraleyes
            duckduckgo-privacy-essentials
            libredirect
            ghostery
            istilldontcareaboutcookies
            firenvim
          ];
          search = {
            force = true;
            default = "DuckDuckGo";
            engines = {
              "Nix Packages" = {
                urls = [
                  {
                    template = "https://search.nixos.org/packages";
                    params = [
                      {
                        name = "type";
                        value = "packages";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = ["@np"];
              };
              "NixOS Wiki" = {
                urls = [
                  {template = "https://nixos.wiki/index.php?search={searchTerms}";}
                ];
                iconUpdateURL = "https://nixos.wiki/favicon.png";
                updateInterval = 24 * 60 * 60 * 1000;
                definedAliases = ["@nw"];
              };
              "Google" = {
                metadata = {
                  hidden = true;
                };
              };
            };
          };
          settings = {
            "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
            "general.smoothScroll" = true;
            "gfx.webrender.all" = true;
            "gfx.webrender.compositor" = true;
            "gfx.webrender.enabled" = true;
            "media.ffmpeg.vaapi.enabled" = true;
            "layers.acceleration.force-enabled" = true;
            "media.ffvpx.enabled" = false;
            "widget.use-xdg-desktop-portal" = true;
            "ui.context_menus.after_mouseup" = true;
            "browser.urlbar.suggest.quickactions" = false;
            "browser.urlbar.suggest.topsites" = false;
            "browser.download.useDownloadDir" = true;
            "browser.tabs.tabmanager.enabled" = false;
            "browser.contentblocking.category" = "strict";
            "browser.startup.homepage" = "https://nixos.org";
            "browser.aboutConfig.showWarning" = false;
            "browser.tabs.warnOnClose" = false;
            "browser.aboutHomeSnippets.updateUrl" = "";
            "browser.bookmarks.showMobileBookmarks" = false;
            "browser.tabs.loadBookmarksInTabs" = false;
            "browser.toolbars.bookmarks.visibility" = "always";
            "browser.newtabpage.pinned" = [
              {
                title = "NixOS";
                url = "https://nixos.org";
              }
            ];
            "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
            "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
            "browser.newtabpage.activity-stream.default.sites" = "";
            "browser.newtabpage.activity-stream.discoverystream.config" = "{}";
            "browser.newtabpage.activity-stream.discoverystream.enabled" = false;
            "browser.newtabpage.activity-stream.discoverystream.endpoints" = "";
            "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
            "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
            "browser.newtabpage.activity-stream.feeds.section.topstories.options" = "{}";
            "browser.newtabpage.activity-stream.feeds.sections" = false;
            "browser.newtabpage.activity-stream.feeds.snippets" = false;
            "browser.newtabpage.activity-stream.feeds.system.systemtick" = false;
            "browser.newtabpage.activity-stream.feeds.system.telemetry" = false;
            "browser.newtabpage.activity-stream.feeds.system.topsites" = false;
            "browser.newtabpage.activity-stream.feeds.topsites" = false;
            "browser.newtabpage.activity-stream.feeds.system.topstories" = false;
            "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = false;
            "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
            "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
            "browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;
            "browser.newtabpage.activity-stream.showSearch" = false;
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "security.pki.sha1_enforcement_level" = 1;
            "security.ssl.treat_unsafe_negotiation_as_broken" = true;
            "network.security.esni.enabled" = true;
            "beacon.enabled" = false;
            "browser.search.geoip.url" = "";
            "browser.search.geoSpecificDefaults" = false;
            "camera.control.face_detection.enabled" = false;
            "device.sensors.enabled" = false;
            "dom.archivereader.enabled" = false;
            "dom.battery.enabled" = false;
            "dom.event.clipboardevents.enabled" = false;
            "dom.event.contextmenu.enabled" = false;
            "dom.webnotifications.requireinteraction.enabled" = false;
            "dom.webnotifications.requireuserinteraction" = false;
            "dom.webnotifications.enabled" = false;
            "dom.gamepad.enabled" = false;
            "dom.maxHardwareConcurrency" = 2;
            "dom.netinfo.enabled" = false;
            "dom.network.enabled" = false;
            "dom.telephony.enabled" = false;
            "dom.vr.enabled" = false;
            "dom.vibrator.enabled" = false;
            "app.normandy.enabled" = false;
            "app.normandy.api_url" = "";
            "app.shield.optoutstudies.enabled" = true;
            "datareporting.healthreport.uploadEnabled" = false;
            "datareporting.healthreport.service.enabled" = false;
            "datareporting.policy.dataSubmissionEnabled" = false;
            "extensions.shield-recipe-client.enabled" = false;
            "extensions.pocket.enabled" = false;
            "loop.logDomains" = false;
            "toolkit.telemetry.archive.enabled" = false;
            "toolkit.telemetry.enabled" = false;
            "toolkit.telemetry.unified" = false;
            "breakpad.reportURL" = "";
            "browser.casting.enabled" = false;
            "browser.crashReports.unsubmittedCheck.enabled" = false;
            "browser.discovery.enabled" = false;
            "browser.formfill.enable" = false;
            "browser.search.update" = false;
            "browser.pagethumbnails.capturing_disabled" = true;
            "browser.tabs.crashReporting.sendReport" = false;
            "browser.uitour.enabled" = true;
            "browser.urlbar.filter.javascript" = true;
            "browser.urlbar.suggest.searches" = false;
            "dom.flyweb.enabled" = false;
            "experiments.supported" = false;
            "experiments.enabled" = false;
            "experiments.manifest.uri" = false;
            "network.allow-experiments" = false;
            "network.captive-portal-service.enabled" = false;
            "plugin.state.flash" = 0;
            "plugin.state.java" = 0;
            "signon.rememberSignons" = false;
            "geo.enabled" = false;
            "geo.wifi.uri" = "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
            "geo.wifi.logging.enabled" = false;
            "intl.accept_languages" = "en-US, en";
            "intl.locale.matchOS" = false;
            "javascript.use_us_english_locale" = true;
            "media.peerconnection.ice.default_address_only" = true;
            "media.peerconnection.ice.no_host" = true;
            "media.webspeech.recognition.enable" = false;
            "network.cookie.cookieBehavior" = 1;
            "network.cookie.thirdparty.sessionOnly" = true;
            "network.dns.disablePrefetch" = true;
            "network.dns.disablePrefetchFromHTTPS" = true;
            "network.http.referer.XOriginPolicy" = 2;
            "network.http.speculative-parallel-limit" = 0;
            "network.IDN_show_punycode" = true;
            "network.manage-offline-status" = false;
            "network.predictor.enabled" = false;
            "network.prefetch-next" = false;
            "privacy.donottrackheader.enabled" = true;
            "privacy.resistFingerprinting" = false;
            "privacy.resistFingerprinting.autoDeclineNoUserInputCanvasPrompts" = false;
            "privacy.trackingprotection.enabled" = true;
            "privacy.trackingprotection.pbmode.enabled" = true;
            "privacy.userContext.enabled" = true;
            "webgl.min_capability_mode" = true;
            "webgl.disable-extensions" = true;
            "webgl.disable-fail-if-major-performance-caveat" = true;
            "webgl.enable-debug-renderer-info" = false;
          };
          userChrome = ''
            # CSS
          '';
          userContent = ''
            # CSS
          '';
        };
      };
    };
  };
}
