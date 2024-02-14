{pkgs, ...}: {
  programs = {
    vscode = {
      userSettings = {
        "direnv.restart.automatic" = true;
        "extensions.experimental.affinity" = {
          "asvetliakov.vscode-neovim" = 1;
        };
        "[nix]" = {
          "editor.defaultFormatter" = "kamadorueda.alejandra";
          "editor.formatOnPaste" = true;
          "editor.formatOnSave" = true;
          "editor.formatOnType" = false;
        };
        "[rust]" = {
          "editor.defaultFormatter" = "rust-lang.rust-analyzer";
        };
        "[toml]" = {
          "editor.defaultFormatter" = "tamasfe.even-better-toml";
        };
        "workbench.colorTheme" = "One Dark";
        "workbench.iconTheme" = "material-icon-theme";
        "terminal.integrated.fontSize" = 16;
        "terminal.integrated.fontFamily" = "Iosevka NFM";
        "terminal.external.linuxExec" = "${pkgs.kitty}/bin/kitty";
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
        "editor.fontSize" = 16;
        "editor.fontFamily" = "Iosevka NFM";
	"editor.fontLigatures" = true;
        "editor.scrollbar.horizontal" = "hidden";
        "editor.scrollbar.vertical" = "hidden";
        "editor.minimap.enabled" = false;
        "editor.cursorBlinking" = "solid";
        "editor.suggestSelection" = "first";
        "editor.tokenColorCustomizations" = {
          "textMateRules" = [
            {
              "name" = "One Dark italic";
              "scope" = [
                "comment"
                "entity.other.attribute-name"
                "keyword"
                "markup.underline.link"
                "storage.modifier"
                "storage.type"
                "string.url"
                "variable.language.super"
                "variable.language.this"
              ];
              "settings" = {
                "fontStyle" = "italic";
              };
            }
            {
              "name" = "One Dark italic reset";
              "scope" = [
                "keyword.operator"
                "keyword.other.type"
                "storage.modifier.import"
                "storage.modifier.package"
                "storage.type.built-in"
                "storage.type.function.arrow"
                "storage.type.generic"
                "storage.type.java"
                "storage.type.primitive"
              ];
              "settings" = {
                "fontStyle" = "";
              };
            }
          ];
        };
        "window.titleBarStyle" = "custom";
        "window.menuBarVisibility" = "toggle";
        "keyboard.dispatch" = "keyCode";
        "security.workspace.trust.enabled" = false;
        "security.workspace.trust.startupPrompt" = "never";
        "security.workspace.trust.banner" = "never";
        "security.workspace.trust.emptyWindow" = false;
        "files.autoSave" = "afterDelay";
        "files.autoSaveDelay" = 1000;
        "alejandra.program" = "alejandra";
        "nixEnvSelector.suggestion" = false;
        "whichkey.sortOrder" = "alphabetically";
        "whichkey.bindings" = [
          {
            key = ";";
            name = "commands";
            type = "command";
            command = "workbench.action.showCommands";
          }
          {
            key = "/";
            name = "comment";
            type = "command";
            command = "vscode-neovim.send";
            args = "<C-/>";
          }
          {
            key = "b";
            name = "Buffers/Editors...";
            type = "bindings";
            bindings = [
              {
                key = "b";
                name = "Show all buffers/editors";
                type = "command";
                command = "workbench.action.showAllEditors";
              }
              {
                key = "d";
                name = "Close active editor";
                type = "command";
                command = "workbench.action.closeActiveEditor";
              }
              {
                key = "h";
                name = "Move editor into left group";
                type = "command";
                command = "workbench.action.moveEditorToLeftGroup";
              }
              {
                key = "j";
                name = "Move editor into below group";
                type = "command";
                command = "workbench.action.moveEditorToBelowGroup";
              }
              {
                key = "k";
                name = "Move editor into above group";
                type = "command";
                command = "workbench.action.moveEditorToAboveGroup";
              }
              {
                key = "l";
                name = "Move editor into right group";
                type = "command";
                command = "workbench.action.moveEditorToRightGroup";
              }
              {
                key = "m";
                name = "Close other editors";
                type = "command";
                command = "workbench.action.closeOtherEditors";
              }
              {
                key = "n";
                name = "Next editor";
                type = "command";
                command = "workbench.action.nextEditor";
              }
              {
                key = "p";
                name = "Previous editor";
                type = "command";
                command = "workbench.action.previousEditor";
              }
              {
                key = "N";
                name = "New untitled editor";
                type = "command";
                command = "workbench.action.files.newUntitledFile";
              }
              {
                key = "u";
                name = "Reopen closed editor";
                type = "command";
                command = "workbench.action.reopenClosedEditor";
              }
              {
                key = "y";
                name = "Copy buffer to clipboard";
                type = "commands";
                commands = [
                  "editor.action.selectAll"
                  "editor.action.clipboardCopyAction"
                  "cancelSelection"
                ];
              }
            ];
          }
          {
            key = "d";
            name = "Debug...";
            type = "bindings";
            bindings = [
              {
                key = "d";
                name = "Start debug";
                type = "command";
                command = "workbench.action.debug.start";
              }
              {
                key = "S";
                name = "Stop debug";
                type = "command";
                command = "workbench.action.debug.stop";
              }
              {
                key = "c";
                name = "Continue debug";
                type = "command";
                command = "workbench.action.debug.continue";
              }
              {
                key = "p";
                name = "Pause debug";
                type = "command";
                command = "workbench.action.debug.pause";
              }
              {
                key = "r";
                name = "Run without debugging";
                type = "command";
                command = "workbench.action.debug.run";
              }
              {
                key = "R";
                name = "Restart debug";
                type = "command";
                command = "workbench.action.debug.restart";
              }
              {
                key = "i";
                name = "Step into";
                type = "command";
                command = "workbench.action.debug.stepInto";
              }
              {
                key = "s";
                name = "Step over";
                type = "command";
                command = "workbench.action.debug.stepOver";
              }
              {
                key = "o";
                name = "Step out";
                type = "command";
                command = "workbench.action.debug.stepOut";
              }
              {
                key = "b";
                name = "Toggle breakpoint";
                type = "command";
                command = "editor.debug.action.toggleBreakpoint";
              }
              {
                key = "B";
                name = "Toggle inline breakpoint";
                type = "command";
                command = "editor.debug.action.toggleInlineBreakpoint";
              }
              {
                key = "j";
                name = "Jump to cursor";
                type = "command";
                command = "debug.jumpToCursor";
              }
              {
                key = "v";
                name = "REPL";
                type = "command";
                command = "workbench.debug.action.toggleRepl";
              }
              {
                key = "w";
                name = "Focus on watch window";
                type = "command";
                command = "workbench.debug.action.focusWatchView";
              }
              {
                key = "W";
                name = "Add to watch";
                type = "command";
                command = "editor.debug.action.selectionToWatch";
              }
            ];
          }
          {
            key = "e";
            name = "Toggle Explorer";
            type = "command";
            command = "workbench.action.toggleSidebarVisibility";
          }
          {
            key = "f";
            name = "Find & Replace...";
            type = "bindings";
            bindings = [
              {
                key = "f";
                name = "File";
                type = "command";
                command = "editor.action.startFindReplaceAction";
              }
              {
                key = "s";
                name = "Symbol";
                type = "command";
                command = "editor.action.rename";
                when = "editorHasRenameProvider && editorTextFocus && !editorReadonly";
              }
              {
                key = "p";
                name = "Project";
                type = "command";
                command = "workbench.action.replaceInFiles";
              }
            ];
          }
          {
            key = "g";
            name = "Git...";
            type = "bindings";
            bindings = [
              {
                key = "b";
                name = "Checkout";
                type = "command";
                command = "git.checkout";
              }
              {
                key = "c";
                name = "Commit";
                type = "command";
                command = "git.commit";
              }
              {
                key = "d";
                name = "Delete Branch";
                type = "command";
                command = "git.deleteBranch";
              }
              {
                key = "f";
                name = "Fetch";
                type = "command";
                command = "git.fetch";
              }
              {
                key = "i";
                name = "Init";
                type = "command";
                command = "git.init";
              }
              {
                key = "m";
                name = "Merge";
                type = "command";
                command = "git.merge";
              }
              {
                key = "p";
                name = "Publish";
                type = "command";
                command = "git.publish";
              }
              {
                key = "s";
                name = "Stash";
                type = "command";
                command = "workbench.view.scm";
              }
              {
                key = "S";
                name = "Stage";
                type = "command";
                command = "git.stage";
              }
              {
                key = "U";
                name = "Unstage";
                type = "command";
                command = "git.unstage";
              }
            ];
          }
          {
            key = "h";
            name = "Split Horizontal";
            type = "command";
            command = "workbench.action.splitEditorDown";
          }
          {
            key = "i";
            name = "Insert...";
            type = "bindings";
            bindings = [
              {
                key = "j";
                name = "Insert line below";
                type = "command";
                command = "editor.action.insertLineAfter";
              }
              {
                key = "k";
                name = "Insert line above";
                type = "command";
                command = "editor.action.insertLineBefore";
              }
              {
                key = "s";
                name = "Insert snippet";
                type = "command";
                command = "editor.action.insertSnippet";
              }
            ];
          }

          {
            key = "m";
            name = "minimap";
            type = "command";
            command = "editor.action.toggleMinimap";
          }
          {
            key = "n";
            name = "highlight";
            type = "command";
            command = "vscode-neovim.send";
            args = ":noh<CR>";
          }
          {
            key = "s";
            name = "Search...";
            type = "bindings";
            bindings = [
              {
                key = "f";
                name = "files";
                type = "command";
                command = "workbench.action.quickOpen";
              }
              {
                key = "t";
                name = "text";
                type = "command";
                command = "workbench.action.findInFiles";
              }
            ];
          }
          {
            key = "S";
            name = "Show...";
            type = "bindings";
            bindings = [
              {
                key = "e";
                name = "Show explorer";
                type = "command";
                command = "workbench.view.explorer";
              }
              {
                key = "s";
                name = "Show search";
                type = "command";
                command = "workbench.view.search";
              }
              {
                key = "g";
                name = "Show source control";
                type = "command";
                command = "workbench.view.scm";
              }
              {
                key = "t";
                name = "Show test";
                type = "command";
                command = "workbench.view.extension.test";
              }
              {
                key = "r";
                name = "Show remote explorer";
                type = "command";
                command = "workbench.view.remote";
              }
              {
                key = "x";
                name = "Show extensions";
                type = "command";
                command = "workbench.view.extensions";
              }
              {
                key = "p";
                name = "Show problem";
                type = "command";
                command = "workbench.actions.view.problems";
              }
              {
                key = "o";
                name = "Show output";
                type = "command";
                command = "workbench.action.output.toggleOutput";
              }
              {
                key = "d";
                name = "Show debug console";
                type = "command";
                command = "workbench.debug.action.toggleRepl";
              }
            ];
          }
          {
            key = "t";
            name = "Terminal...";
            type = "bindings";
            bindings = [
              {
                key = "t";
                name = "Toggle Terminal";
                type = "command";
                command = "workbench.action.togglePanel";
              }
            ];
          }
          {
            key = "T";
            name = "UI toggles...";
            type = "bindings";
            bindings = [
              {
                key = "b";
                name = "Toggle side bar visibility";
                type = "command";
                command = "workbench.action.toggleSidebarVisibility";
              }
              {
                key = "j";
                name = "Toggle panel visibility";
                type = "command";
                command = "workbench.action.togglePanel";
              }
              {
                key = "F";
                name = "Toggle full screen";
                type = "command";
                command = "workbench.action.toggleFullScreen";
              }
              {
                key = "s";
                name = "Select theme";
                type = "command";
                command = "workbench.action.selectTheme";
              }
              {
                key = "m";
                name = "Toggle maximized panel";
                type = "command";
                command = "workbench.action.toggleMaximizedPanel";
              }
              {
                key = "t";
                name = "Toggle tool/activity bar visibility";
                type = "command";
                command = "workbench.action.toggleActivityBarVisibility";
              }
              {
                key = "T";
                name = "Toggle tab visibility";
                type = "command";
                command = "workbench.action.toggleTabsVisibility";
              }
            ];
          }
          {
            key = "v";
            name = "Split Vertical";
            type = "command";
            command = "workbench.action.splitEditor";
          }
          {
            key = "w";
            name = "Window...";
            type = "bindings";
            bindings = [
              {
                key = "W";
                name = "Focus previous editor group";
                type = "command";
                command = "workbench.action.focusPreviousGroup";
              }
              {
                key = "h";
                name = "Move editor group left";
                type = "command";
                command = "workbench.action.moveActiveEditorGroupLeft";
              }
              {
                key = "j";
                name = "Move editor group down";
                type = "command";
                command = "workbench.action.moveActiveEditorGroupDown";
              }
              {
                key = "k";
                name = "Move editor group up";
                type = "command";
                command = "workbench.action.moveActiveEditorGroupUp";
              }
              {
                key = "l";
                name = "Move editor group right";
                type = "command";
                command = "workbench.action.moveActiveEditorGroupRight";
              }
              {
                key = "t";
                name = "Toggle editor group sizes";
                type = "command";
                command = "workbench.action.toggleEditorWidths";
              }
              {
                key = "m";
                name = "Maximize editor group";
                type = "command";
                command = "workbench.action.minimizeOtherEditors";
              }
              {
                key = "M";
                name = "Maximize editor group and hide side bar";
                type = "command";
                command = "workbench.action.maximizeEditor";
              }
              {
                key = "=";
                name = "Reset editor group sizes";
                type = "command";
                command = "workbench.action.evenEditorWidths";
              }
              {
                key = "z";
                name = "Combine all editors";
                type = "command";
                command = "workbench.action.joinAllGroups";
              }
              {
                key = "d";
                name = "Close editor group";
                type = "command";
                command = "workbench.action.closeEditorsInGroup";
              }
              {
                key = "x";
                name = "Close all editor groups";
                type = "command";
                command = "workbench.action.closeAllGroups";
              }
            ];
          }
          {
            key = "z";
            name = "Toggle zen mode";
            type = "command";
            command = "workbench.action.toggleZenMode";
          }
        ];
      };
    };
  };
}
