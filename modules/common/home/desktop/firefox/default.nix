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
  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
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
        removed = {};
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
  programs = {
    firefox = {
      enable = true;
      package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
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
            istilldontcareaboutcookies
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
