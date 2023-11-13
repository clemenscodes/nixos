{ pkgs , user, config, inputs, ...}: {
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
              {
                Name = "Brave Search";
                Alias = "brave";
                Method = "GET";
                Description = "Search on the Brave search engine.";
                PostData = "";
                URLTemplate = "https://search.brave.com/search?q={searchTerms}";
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
          Homepage = {
            URL = "https://search.brave.com";
            Locked = true;
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
                      { name = "type"; value = "packages"; }
                      { name = "query"; value = "{searchTerms}"; }
                    ];
                  }
                ];
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@np" ];
              };
              "NixOS Wiki" = {
                urls = [
                  { template = "https://nixos.wiki/index.php?search={searchTerms}"; }
                ];
                iconUpdateURL = "https://nixos.wiki/favicon.png";
                updateInterval = 24 * 60 * 60 * 1000;
                definedAliases = [ "@nw" ];
              };
              "Google" = {
                metadata = {
                  hidden = true;
                }; 
              };
              "Amazon.com" = {
                metadata = {
                  hidden = true;
                }; 
              };
              "Bing" = {
                metadata = {
                  hidden = true;
                }; 
              };
              "eBay" = {
                metadata = {
                  hidden = true;
                }; 
              };
            };
          };
          settings = {
            "general.smoothScroll" = true;
            "gfx.webrender.all" = true;
            "gfx.webrender.enabled" = true;
            "media.ffmpeg.vaapi.enabled" = true;
            "media.ffvpx.enabled" = false;
            "browser.aboutConfig.showWarning" = false;
            "browser.tabs.warnOnClose" = false;
            "widget.use-xdg-desktop-portal" = true;
            "ui.context_menus.after_mouseup" = true;
            "browser.toolbars.bookmarks.visibility" = "never";
            "browser.urlbar.suggest.quickactions" = false;
            "browser.urlbar.suggest.topsites" = false;
            "browser.tabs.tabmanager.enabled" = false;
            "browser.contentblocking.category" = "strict";
            "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
          };
          extraConfig = ''
            user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
            user_pref("full-screen-api.ignore-widgets", true);
            user_pref("media.ffmpeg.vaapi.enabled", true);
            user_pref("media.rdd-vpx.enabled", true);
          '';
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
