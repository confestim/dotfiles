{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    # # make immutable extrensions
    mutableExtensionsDir = true;

    profiles.default.extensions = pkgs.nix4vscode.forVscode [
      "dracula-theme.theme-dracula"
      "bbenoist.nix"
      "jnoortheen.nix-ide"
      "detachhead.basedpyright"
      "donjayamanne.githistory"
      "haskell.haskell"
      "justusadam.language-haskell"
      "james-yu.latex-workshop"
      "yzhang.markdown-all-in-one"
      "davidanson.vscode-markdownlint"
      "alefragnani.bookmarks"
      "WakaTime.vscode-wakatime"
      "github.copilot"
      "wallenwang.ccls-plus"
      "vibhanshugarg.vibhanshugarg-codenotes"
      "myriad-dreamin.tinymist"
    ];

    profiles.default.userSettings = {

      # Git
      "git.confirmSync" = false;
      "git.autofetch" = true;
      "git.enableSmartCommit" = true;
      "git.openRepositoryInParentFolders" = "always";

      # Font
      "editor.fontFamily" = "Fira Code";
      "terminal.integrated.fontFamily" = "Agave Nerd Font";
      "editor.fontSize" = 18;
      "terminal.integrated.fontSize" = 19;
      "editor.fontLigatures" = true;

      # Editor
      "editor.unicodeHighlight.invisibleCharacters" = false;
      "editor.formatOnPaste" = false;
      "editor.formatOnSave" = false;
      "editor.renderWhitespace" = "all";
      "editor.minimap.enabled" = false;
      "editor.linkedEditing" = true;
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "editor.rulers" = [
        {
          "column" = 80;
          "color" = "#00FF0010";
        }
        {
          "column" = 100;
          "color" = "#BDB76B15";
        }
        {
          "column" = 120;
          "color" = "#FA807219";
        }
      ];
      "editor.unicodeHighlight.includeComments" = true;

      # Explorer
      "explorer.confirmDragAndDrop" = false;
      "explorer.autoReveal" = false;
      "explorer.compactFolders" = false;
      "explorer.confirmDelete" = false;
      "explorer.fileNesting.patterns" = {
        "*.ts" = "\${capture}.js";
        "*.js" = "\${capture}.js.map, \${capture}.min.js, \${capture}.d.ts";
        "*.jsx" = "\${capture}.js";
        "*.tsx" = "\${capture}.ts";
        "tsconfig.json" = "tsconfig.*.json";
        "package.json" = "package-lock.json, yarn.lock, pnpm-lock.yaml, bun.lockb";
      };
      # Workbench
      "workbench.editorAssociations" = {
        "*.pdf" = "pdf.preview";
        "*.png" = "editor.excalidraw";
      };
      "workbench.startupEditor" = "none";
      "workbench.colorTheme" = "Dracula Theme";
      "workbench.iconTheme" = "bearded-icons";
      "workbench.activityBar.location" = "bottom";
      "workbench.editor.revealIfOpen" = true;
      "workbench.tree.indent" = 20;
      "workbench.panel.showLabels" = false;
      "workbench.sideBar.location" = "right";
      "workbench.colorCustomizations" = {
        "editor.wordHighlightStrongBorder" = "#FF6347";
        "editor.wordHighlightBorder" = "#FFD700";
        "editor.selectionHighlightBorder" = "#A9A9A9";
      };

      # Window
      "window.titleBarStyle" = "custom";
      "window.customTitleBarVisibility" = "auto";
      "window.confirmSaveUntitledWorkspace" = false;

      # Terminal
      "terminal.integrated.enableMultiLinePasteWarning" = false;
      "terminal.integrated.tabs.hideCondition" = "never";
      "terminal.integrated.enablePersistentSessions" = false;
      "terminal.integrated.defaultProfile.linux" = "zsh";

      # Files
      "files.autoSave" = "afterDelay";
      "files.associations" = {
        "*.excalidraw" = "json";
        "*.excalidrawlib" = "json";
        "*.asm" = "lc3";
        "*.rmd" = "rmarkdown";
        "*.py" = "python";
      };

      # Telemetry/Privacy
      "telemetry.telemetryLevel" = "off";
      "redhat.telemetry.enabled" = false;
      "chat.commandCenter.enabled" = false;
      "chat.extensionTools.enabled" = false;
      "chat.focusWindowOnConfirmation" = false;
      "chat.disableAIFeatures" = false;

      # Python
      "python.pythonPath" = "/usr/bin/python";
      "python.analysis.typeCheckingMode" = "basic";
      "python.languageServer" = "Default";
      "python.createEnvironment.trigger" = "off";

      "[python]" = {
        "editor.defaultFormatter" = "ms-python.black-formatter";
      };

      # C/C++
      "C_Cpp.autocompleteAddParentheses" = true;
      "C_Cpp.default.cppStandard" = "c++23";
      "C_Cpp.default.cStandard" = "c99";
      "C_Cpp.intelliSenseEngine" = "disabled";

      "[c]" = {
        "editor.defaultFormatter" = "ccls-project.ccls";
      };
      "[cpp]" = {
        "editor.defaultFormatter" = "ms-vscode.cpptools";
      };
      "[java]" = {
        "editor.defaultFormatter" = "redhat.java";
      };
      "[latex]" = {
        "editor.defaultFormatter" = "mathematic.vscode-latex";
      };
      "[tex]" = {
        "editor.defaultFormatter" = "James-Yu.latex-workshop";
      };
      "[xml]" = {
        "editor.defaultFormatter" = "DotJoshJohnson.xml";
      };
      "[haskell]" = {
        "editor.defaultFormatter" = "haskell.haskell";
      };
      "[html]" = {
        "editor.defaultFormatter" = "vscode.html-language-features";
      };

      # Java
      "java.compile.nullAnalysis.mode" = "automatic";
      "java.configuration.updateBuildConfiguration" = "automatic";

      # Diff editor
      "diffEditor.ignoreTrimWhitespace" = false;

      # Security
      "security.workspace.trust.untrustedFiles" = "open";

      # GitHub Copilot
      "github.copilot.enable" = {

        "*" = true;
        "plaintext" = false;
        "markdown" = true;
        "c" = true;
        "python" = true;
        "java" = true;
      };
      "github.copilot.chat.codesearch.enabled" = true;
      "github.copilot.nextEditSuggestions.enabled" = true;

    };
    profiles.default.keybindings = [
      {
        key = "ctrl+k";
        command = "editor.action.deleteLines";
        when = "editorTextFocus && !editorReadonly";
      }
      {
        key = "ctrl+n";
        command = "explorer.newFile";
      }
    ];
  };

  home.file.".config/VSCodium/product.json".text = builtins.toJSON {
    extensionsGallery = {
      serviceUrl = "https://marketplace.visualstudio.com/_apis/public/gallery";
      cacheUrl = "https://vscode.blob.core.windows.net/gallery/index";
      itemUrl = "https://marketplace.visualstudio.com/items";
      controlUrl = "";
      recommendationsUrl = "";
    };
  };

  home.file.".config/VSCodium/argv.json".text = builtins.toJSON {
    "password-store" = "gnome-libsecret";
  };
}
