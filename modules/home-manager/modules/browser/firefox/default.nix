{inputs}: {
  nixpkgs,
  system,
  config,
  osConfig,
  lib,
  ...
}: let
  cfg = config.modules.browser;
  user = osConfig.modules.users.user;
  pkgs = import nixpkgs {
    inherit system;
    config = {
      allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) ["untrap-for-youtube"];
    };
    overlays = [inputs.nur.overlay];
  };
in
  with lib; {
    options = {
      modules = {
        browser = {
          firefox = {
            enable = mkEnableOption "Enable firefox" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.firefox.enable) {
      programs = {
        firefox = {
          enable = cfg.firefox.enable;
          nativeMessagingHosts = [pkgs.gnome-browser-connector];
          policies = {
            DisableAppUpdate = true;
            DisableFirefoxStudies = true;
            DisableFirefoxAccounts = true;
            DisableTelemetry = true;
            DisableFormHistory = true;
            DisablePocket = true;
            DisableAccounts = true;
            DisableProfileImport = true;
            DisableFirefoxScreenshots = true;
            EnableTrackingProtection = {
              Value = true;
              Locked = true;
              Cryptomining = true;
              EmailTracking = true;
              Fingerprinting = true;
            };
            FirefoxHome = {
              Search = true;
              TopSites = false;
              SponsoredTopSites = false;
              Highlights = false;
              Pocket = false;
              SponsoredPocket = false;
              Snippets = false;
              Locked = true;
            };
            FirefoxSuggest = {
              WebSuggestions = false;
              SponsoredSuggestions = false;
              ImproveSuggest = false;
              Locked = true;
            };
            Homepage = {
              StartPage = "previous-session";
              Locked = true;
            };
            DNSOverHTTPS = {
              Enabled = true;
              ProviderURL = "https://adblock.dns.mullvad.net/dns-query";
              Locked = true;
            };
            PasswordManagerEnabled = false;
            PrimaryPassword = false;
            OfferToSaveLoginsDefault = false;
            OverrideFirstRunPage = "";
            OverridePostUpdatePage = "";
            DontCheckDefaultBrowser = true;
            DisplayMenuBar = "default-off";
            SearchBar = "unified";
            NoDefaultBookmarks = false;
            NetworkPrediction = false;
            Preferences = {
              "accessibility.force_disabled" = {
                Value = 1;
                Status = "locked";
              };
              "browser.aboutConfig.showWarning" = {
                Value = false;
                Status = "locked";
              };
              "browser.aboutHomeSnippets.updateUrl" = {
                Value = "";
                Status = "locked";
              };
              "browser.crashReports.unsubmittedCheck.autoSubmit2" = {
                Value = false;
                Status = "locked";
              };
              "browser.selfsupport.url" = {
                Value = "";
                Status = "locked";
              };
              "browser.startup.homepage_override.mstone" = {
                Value = "ignore";
                Status = "locked";
              };
              "browser.startup.homepage_override.buildID" = {
                Value = "";
                Status = "locked";
              };
              "browser.tabs.firefox-view" = {
                Value = false;
                Status = "locked";
              };
              "browser.tabs.firefox-view-next" = {
                Value = false;
                Status = "locked";
              };
              "browser.urlbar.suggest.history" = {
                Value = true;
                Status = "locked";
              };
              "browser.urlbar.suggest.topsites" = {
                Value = true;
                Status = "locked";
              };
              "browser.translations.automaticallyPopup" = {
                Value = false;
                Status = "locked";
              };
              "dom.security.https_only_mode" = {
                Value = true;
                Status = "locked";
              };
              "extensions.htmlaboutaddons.recommendations.enabled" = {
                Value = false;
                Status = "locked";
              };
              "extensions.recommendations.themeRecommendationUrl" = {
                Value = "";
                Status = "locked";
              };
              "gfx.canvas.accelerated.cache-items" = {
                Value = 4096;
                Status = "locked";
              };
              "gfx.canvas.accelerated.cache-size" = {
                Value = 512;
                Status = "locked";
              };
              "gfx.content.skia-font-cache-size" = {
                Value = 20;
                Status = "locked";
              };
              "network.dns.disablePrefetch" = {
                Value = false;
                Status = "locked";
              };
              "network.dns.disablePrefetchFromHTTPS" = {
                Value = false;
                Status = "locked";
              };
              "network.http.max-connections" = {
                Value = 1800;
                Status = "locked";
              };
              "network.http.max-persistent-connections-per-server" = {
                Value = 10;
                Status = "locked";
              };
              "network.http.max-urgent-start-excessive-connections-per-host" = {
                Value = 5;
                Status = "locked";
              };
              "network.http.pacing.requests.enabled" = {
                Value = false;
                Status = "locked";
              };
              "network.IDN_show_punycode" = {
                Value = true;
                Status = "locked";
              };
              "network.predictor.enabled" = {
                Value = false;
                Status = "locked";
              };
              "network.prefetch-next" = {
                Value = false;
                Status = "locked";
              };
              "signon.management.page.breach-alerts.enabled" = {
                Value = false;
                Status = "locked";
              };
            };
          };
          profiles = {
            ${user} = {
              id = 0;
              name = user;
              extensions = with pkgs.nur.repos.rycee.firefox-addons; [
                decentraleyes
                ublock-origin
                bitwarden
                istilldontcareaboutcookies
                firefox-color
                sponsorblock
                df-youtube
                untrap-for-youtube
                zotero-connector
                vimium
              ];
              search = {
                force = true;
                default = "DuckDuckGo";
                privateDefault = "DuckDuckGo";
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
                    definedAliases = ["nix"];
                  };
                  "MyNixOS" = {
                    urls = [
                      {
                        template = "https://mynixos.com/search";
                        params = [
                          {
                            name = "q";
                            value = "{searchTerms}";
                          }
                        ];
                      }
                    ];
                    icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                    definedAliases = ["mnix"];
                  };
                  "NixOS Wiki" = {
                    urls = [
                      {template = "https://nixos.wiki/index.php?search={searchTerms}";}
                    ];
                    iconUpdateURL = "https://nixos.wiki/favicon.png";
                    updateInterval = 24 * 60 * 60 * 1000;
                    definedAliases = ["nw"];
                  };
                  "Google" = {
                    metadata = {
                      hidden = true;
                      alias = "@g";
                    };
                  };
                };
              };
              bookmarks = import ./bookmarks;
              settings = {
                "general.smoothScroll" = true;
                "app.update.channel" = "default";
                "browser.download.useDownloadDir" = true;
                "browser.urlbar.suggest.quickactions" = false;
                "browser.urlbar.suggest.topsites" = false;
                "browser.urlbar.shortcuts.bookmarks" = false;
                "browser.urlbar.shortcuts.history" = false;
                "browser.urlbar.shortcuts.tabs" = false;
                "browser.urlbar.suggest.bookmark" = false;
                "browser.urlbar.suggest.engines" = false;
                "browser.urlbar.suggest.history" = false;
                "browser.urlbar.suggest.openpage" = false;
                "browser.tabs.tabmanager.enabled" = false;
                "browser.tabs.loadBookmarksInTabs" = false;
                "browser.bookmarks.showMobileBookmarks" = false;
                "browser.bookmarks.addedImportButton" = false;
                "browser.toolbars.bookmarks.visibility" = "always";
                "browser.shell.checkDefaultBrowser" = false;
                "browser.shell.defaultBrowserCheckCount" = 1;
                "browser.places.importBookmarksHTML" = true;
                "browser.helperApps.deleteTempFileOnExit" = true;
                "browser.newtabpage.activity-stream.default.sites" = "";
                "browser.newtabpage.activity-stream.feeds.topsites" = false;
                "browser.newtabpage.activity-stream.showSponsored" = false;
                "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
                "browser.uidensity" = 1;
                "datareporting.policy.dataSubmissionEnabled" = false;
                "datareporting.healthreport.uploadEnabled" = false;
                "toolkit.telemetry.unified" = false;
                "toolkit.telemetry.enabled" = false;
                "toolkit.telemetry.server" = "data:,";
                "toolkit.telemetry.archive.enabled" = false;
                "toolkit.telemetry.newProfilePing.enabled" = false;
                "toolkit.telemetry.shutdownPingSender.enabled" = false;
                "toolkit.telemetry.updatePing.enabled" = false;
                "toolkit.telemetry.bhrPing.enabled" = false;
                "toolkit.telemetry.firstShutdownPing.enabled" = false;
                "toolkit.telemetry.coverage.opt-out" = true;
                "toolkit.coverage.opt-out" = true;
                "toolkit.coverage.endpoint.base" = "";
                "browser.ping-centre.telemetry" = false;
                "browser.newtabpage.activity-stream.feeds.telemetry" = false;
                "browser.newtabpage.activity-stream.telemetry" = false;
                "toolkit.telemetry.reportingpolicy.firstRun" = false;
                "toolkit.telemetry.shutdownPingSender.enabledFirstsession" = false;
                "browser.vpn_promo.enabled" = false;
                "network.protocol-handler.expose.magnet" = false;
                "network.dns.force_use_https_rr" = false;
                "network.trr.mode" = 3;
                "network.trr.uri" = "https://family.dns.mullvad.net/dns-query";
                "network.trr.useGET" = true;
                "network.connectivity-service.enabled" = false;
                "network.security.esni.enabled" = true;
                "widget.use-xdg-desktop-portal" = true;
                "media.ffmpeg.vaapi.enabled" = true;
                "media.autoplay.enabled" = false;
                "layers.acceleration.force-enabled" = true;
                "gfx.webrender.all" = true;
                "gfx.webrender.compositor" = true;
                "gfx.webrender.enabled" = true;
                "ui.context_menus.after_mouseup" = true;
                "extensions.autoDisableScopes" = 0;
                "extensions.activeThemeID" = "firefox-alpenglow@mozilla.org";
                "extensions.webcompat.enable_picture_in_picture_overrides" = true;
                "extensions.webcompat.enable_shims" = true;
                "extensions.webcompat.perform_injections" = true;
                "extensions.webcompat.perform_ua_overrides" = true;
                "extensions.getAddons.showPane" = false;
                "extensions.htmlaboutaddons.recommendations.enabled" = false;
              };
              userChrome = ''
                /* Sidebery settings:
                #root.root {--general-border-radius: 8px;}
                #root.root:not(:hover) .TabsPanel {--tabs-indent: 0px;}
                #root.root .PinnedTabsBar {flex-wrap: nowrap;}
                */

                /* Adapted from https://github.com/MrOtherGuy/firefox-csshacks/tree/master/chrome/autohide_sidebar.css
                Above file is available under Mozilla Public License v. 2.0
                See the above repository for updates as well as full license text. */

                /* Disable tabs bar, sidebar splitter and header */
                #TabsToolbar,
                #sidebar-header,
                #sidebar-splitter {
                  display: none !important;
                }

                /* Show sidebar only when the cursor is over it
                   The border controlling sidebar width will be removed so you'll need to modify
                   these values to change width
                */
                #sidebar-box {
                  --uc-sidebar-width: 34px;
                  --uc-sidebar-hover-width: 210px;
                  --uc-autohide-sidebar-delay: 50ms;
                  --uc-autohide-transition-duration: 100ms;
                  --uc-autohide-transition-type: ease-out;
                  position: relative;
                  min-width: var(--uc-sidebar-width) !important;
                  width: var(--uc-sidebar-width) !important;
                  max-width: var(--uc-sidebar-width) !important;
                  z-index: 1;
                }

                #sidebar-box[positionend] {
                  direction: rtl;
                }
                #sidebar-box[positionend] > * {
                  direction: ltr;
                }

                #sidebar-box[positionend]:-moz-locale-dir(rtl) {
                  direction: ltr;
                }
                #sidebar-box[positionend]:-moz-locale-dir(rtl) > * {
                  direction: rtl;
                }

                #main-window[sizemode="fullscreen"] #sidebar-box {
                  --uc-sidebar-width: 1px;
                }

                #sidebar {
                  transition: min-width var(--uc-autohide-transition-duration) var(--uc-autohide-transition-type) var(--uc-autohide-sidebar-delay) !important;
                  min-width: var(--uc-sidebar-width) !important;
                  will-change: min-width;
                }

                #sidebar-box:hover > #sidebar {
                  min-width: var(--uc-sidebar-hover-width) !important;
                  transition-delay: 0ms !important;
                }

                .sidebar-panel {
                  background-color: transparent !important;
                  color: var(--newtab-text-primary-color) !important;
                }

                .sidebar-panel #search-box {
                  -moz-appearance: none !important;
                  background-color: rgba(249, 249, 250, 0.1) !important;
                  color: inherit !important;
                }

                /* Move statuspanel to the other side when sidebar is hovered so it doesn't get covered by sidebar */

                #sidebar-box:not([positionend]):hover ~ #appcontent #statuspanel {
                  inset-inline: auto 0px !important;
                }
                #sidebar-box:not([positionend]):hover ~ #appcontent #statuspanel-label {
                  margin-inline: 0px !important;
                  border-left-style: solid !important;
                }
              '';
              userContent = ''
                # CSS
              '';
            };
          };
        };
      };
      xdg = {
        enable = cfg.firefox.enable;
        mimeApps = {
          enable = cfg.firefox.enable;
          associations = {
            added = {
              "x-scheme-handler/http" = ["firefox.desktop"];
              "x-scheme-handler/https" = ["firefox.desktop"];
              "x-scheme-handler/chrome" = ["firefox.desktop"];
              "text/html" = ["firefox.desktop"];
              "application/x-extension-htm" = ["firefox.desktop"];
              "application/x-extension-html" = ["firefox.desktop"];
              "application/x-extension-shtml" = ["firefox.desktop"];
              "application/xhtml+xml" = ["firefox.desktop"];
              "application/x-extension-xhtml" = ["firefox.desktop"];
              "application/x-extension-xht" = ["firefox.desktop"];
            };
          };
          defaultApplications = {
            "x-scheme-handler/http" = ["firefox.desktop"];
            "x-scheme-handler/https" = ["firefox.desktop"];
            "x-scheme-handler/chrome" = ["firefox.desktop"];
            "text/html" = ["firefox.desktop"];
            "application/x-extension-htm" = ["firefox.desktop"];
            "application/x-extension-html" = ["firefox.desktop"];
            "application/x-extension-shtml" = ["firefox.desktop"];
            "application/xhtml+xml" = ["firefox.desktop"];
            "application/x-extension-xhtml" = ["firefox.desktop"];
            "application/x-extension-xht" = ["firefox.desktop"];
          };
        };
        desktopEntries = {
          firefox = {
            name = "Firefox";
            genericName = "Web Browser";
            exec = "firefox %U";
            icon = "firefox";
            terminal = false;
            categories = ["Application" "Network" "WebBrowser"];
            mimeType = ["text/html" "text/xml"];
          };
        };
      };
    };
  }
