{
  inputs,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./theming.nix
    # ./settings.nix

    ./programs/thunar.nix
    ./programs/hyprland/default.nix
    ./var.nix
    ./programs/shell/default.nix
    ./programs/wofi/default.nix
    ./scripts/default.nix
    # ./programs/nvim/default.nix
    # ./programs/dunst/default.nix
    # ./programs/wofi/cider.nix
    # ./programs/waybar/default.nix
    # ./programs/quickshell/default.nix
    # ./programs/clipman.nix

    ./programs/spicetify.nix
    # inputs.spicetify-nix.homeManagerModules.default

  ];
  # config = {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.

  home.pointerCursor.enable = true;

  home.username = "jonwick";
  home.homeDirectory = "/home/jonwick";
  services.network-manager-applet.enable = true;
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "openclaw-2026.6.5"
    "electron-39.8.10"
    "firefox-esr-140-bin-unwrapped-140.17.0esr"

  ];

  programs.noctalia = {
    enable = true;
    systemd.enable = true;

    # Keep noctalia's own build (5.2.1) instead of nixpkgs' (5.2.0).
    package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;

    # Optional
    # compositor = "niri";
    # theme = "default";
  };
  # services.xserver = {
  #     enable = true;
  #   };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.
  gtk.iconTheme.name = "MoreWaita";
  # gtk.gtk4.theme.package = pkgs.orchis-theme.override { tweaks = [ "black" ]; };
  # gtk.gtk4.theme.name = "Orchis-black";
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages =
    let
      # Fix NVIDIA EGL errors on Wayland for Chromium browsers
      nvidiaChromiumFix = [ "--disable-gpu-compositing" ];
      wrappedVivaldi = pkgs.symlinkJoin {
        name = "vivaldi";
        paths = [ pkgs.vivaldi ];
        nativeBuildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          wrapProgram "$out/bin/vivaldi" --add-flags "${builtins.concatStringsSep " " nvidiaChromiumFix}"
        '';
      };
      wrappedBrave = pkgs.symlinkJoin {
        name = "brave";
        paths = [ pkgs.brave ];
        nativeBuildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          wrapProgram "$out/bin/brave" --add-flags "${builtins.concatStringsSep " " nvidiaChromiumFix}"
        '';
      };
    in
    [
      # System & Core Utilities
      pkgs.coreutils
      pkgs.pkg-config
      pkgs.libiconv
      pkgs.zlib
      pkgs.xz
      pkgs.bzip2
      pkgs.qt6.qtwebengine
      pkgs.qt6.qtwayland
      pkgs.libdrm
      pkgs.mesa
      # pkgs.nss
      pkgs.glib
      # Fonts
      pkgs.nerd-fonts.lilex
      pkgs.nerd-fonts.open-dyslexic
      pkgs.nerd-fonts.hack
      pkgs.morewaita-icon-theme

      # Terminal & Shell
      pkgs.ghostty
      pkgs.bun
      pkgs.nodejs

      # Development Tools
      pkgs.vscode
      pkgs.rstudio
      pkgs.jdt-language-server
      pkgs.jupyter
      pkgs.opencode
      pkgs.racket
      pkgs.matlab
      pkgs.wrangler
      inputs.nixvim.packages.${pkgs.system}.nvim
      inputs.psysonic.packages.${pkgs.system}.psysonic
      inputs.hyprfm.packages.${pkgs.system}.default

      # Version Control & CLI Tools
      pkgs.fastfetch
      pkgs.speedtest-cli
      pkgs.uv
      pkgs.mamba-cpp
      pkgs.conda

      # Browsers
      wrappedVivaldi
      wrappedBrave

      # Communication
      pkgs.teams-for-linux
      pkgs.discord
      pkgs.geary
      pkgs.thunderbird
      pkgs.kdePackages.kdeconnect-kde

      # Android & Mobile
      pkgs.localsend
      pkgs.scrcpy
      pkgs.android-tools

      # Office & Productivity
      pkgs.onlyoffice-desktopeditors
      pkgs.libreoffice
      pkgs.wpsoffice-cn
      pkgs.zotero # 10.0.4 has build issues - temporarily disabled
      # pkgs.zotero
      pkgs.obsidian
      pkgs.via
      pkgs.feishin

      # Media & Graphics
      pkgs.vlc
      pkgs.fiji
      pkgs.pymol
      pkgs.igv
      pkgs.spicetify-cli
      pkgs.lutris
      pkgs.lunar-client

      # Security & Password Management
      pkgs.bitwarden-desktop
      pkgs.bitwarden-cli
      pkgs.bitwarden-menu
      pkgs.rbw
      pkgs.pinentry-all
      pkgs.proton-vpn

      pkgs.openconnect
      pkgs.sqlite

      # VPN helper (cookie based)
      (pkgs.writeShellScriptBin "vpn-wwu" ''
        #!/usr/bin/env bash
        set -e

        echo "[vpn-wwu] Opening WWU VPN portal in Vivaldi..."
        ${pkgs.vivaldi}/bin/vivaldi "https://remotevpn.wwu.edu" >/dev/null 2>&1 &

        echo "[vpn-wwu] Complete WWU SSO/MFA login in the browser."
        echo "[vpn-wwu] After the login finishes and you're redirected, press Enter here."
        read -r

        COOKIE_DB="$HOME/.config/vivaldi/Default/Network/Cookies"
        if [ ! -f "$COOKIE_DB" ]; then
          COOKIE_DB="$HOME/.config/vivaldi/Default/Cookies"
        fi

        COOKIE=""

        if [ -f "$COOKIE_DB" ]; then
          COOKIE=$(${pkgs.sqlite}/bin/sqlite3 "file:$COOKIE_DB?mode=ro" \
            "SELECT value FROM cookies WHERE host_key LIKE '%remotevpn.wwu.edu%' AND name='acSamlv2Token' ORDER BY creation_utc DESC LIMIT 1;" 2>/dev/null || true)
        fi

        if [ -z "$COOKIE" ]; then
          echo "[vpn-wwu] Could not auto-extract acSamlv2Token from Vivaldi."
          echo "[vpn-wwu] Manually grab it: F12 -> Application -> Cookies -> https://remotevpn.wwu.edu -> acSamlv2Token"
          read -rp "[vpn-wwu] Paste acSamlv2Token: " COOKIE
        else
          echo "[vpn-wwu] Auto-extracted acSamlv2Token from Vivaldi cookies."
        fi

        echo "[vpn-wwu] Connecting with openconnect..."
        exec ${pkgs.openconnect}/bin/openconnect --protocol=anyconnect --authgroup=MFA-Split-Tunnel2 --cookie="acSamlv2Token=$COOKIE" remotevpn.wwu.edu
      '')

      # Wayland & Desktop
      pkgs.waydroid
      pkgs.adguardhome
      pkgs.iwgtk

      # Screenshot & Clipboard
      pkgs.cliphist
      pkgs.swappy
      pkgs.slurp
      pkgs.grimblast

      # Document Processing
      pkgs.texliveFull
      pkgs.texlivePackages.platex-tools

      # Bioinformatics
      pkgs.samtools

      # Other
      pkgs.pwvucontrol
    ];

  # xdg.autostart = {
  #   enable = true;
  #
  #   entries = [
  #     {
  #       name = "Asus";
  #       exec = "${pkgs.asusctl}/bin/asusctl";
  #       terminal = false;
  #     }
  #     {
  #       name = "thunderbird";
  #       exec = "${pkgs.thunderbird}/bin/thunderbird";
  #       terminal = false;
  #     }
  #     {
  #       name = "Teams";
  #       exec = "${pkgs.teams-for-linux}/bin/teams-for-linux";
  #       terminal = false;
  #     }
  #
  #   ];
  # };
  xdg.desktopEntries.asus = {
    name = "Asus";
    exec = "${pkgs.asusctl}/bin/asusctl";
    terminal = false;
  };
  xdg.desktopEntries.teams = {
    name = "Teams for Linux";
    exec = "${pkgs.teams-for-linux}/bin/teams-for-linux --minimized";
    terminal = false;
  };
  xdg.desktopEntries.thunderbird = {
    name = "Thunderbird";
    exec = "${pkgs.thunderbird}/bin/thunderbird";
    terminal = false;
  };
  xdg.desktopEntries.kdeconnect = {
    name = "KDE Connect";
    exec = "${pkgs.kdePackages.kdeconnect-kde}/bin/kdeconnect-indicator";
    terminal = false;
  };
  xdg.desktopEntries.igv = {
    name = "IGV";
    genericName = "Integrative Genomics Viewer";
    comment = "Interactive genome browser";
    exec = "${pkgs.igv}/bin/igv";
    icon = "applications-science";
    terminal = false;
    categories = [
      "Science"
      "Biology"
      "Java"
    ];
    settings.Keywords = "IGV;genome;browser;bioinformatics;";
  };
  xdg.autostart.enable = true;
  xdg.autostart.entries = [
    "${pkgs.thunderbird}/share/applications/thunderbird.desktop"
    "${pkgs.kdePackages.kdeconnect-kde}/share/applications/org.kde.kdeconnect.daemon.desktop"
    "${pkgs.kdePackages.kdeconnect-kde}/share/applications/org.kde.kdeconnect.nonplasma.desktop"
  ];
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/jonwick/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";

  };

  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    # Browser
    "text/html" = "vivaldi-stable.desktop";
    "x-scheme-handler/http" = "vivaldi-stable.desktop";
    "x-scheme-handler/https" = "vivaldi-stable.desktop";
    "x-scheme-handler/ftp" = "vivaldi-stable.desktop";
    "x-scheme-handler/about" = "vivaldi-stable.desktop";
    "x-scheme-handler/unknown" = "vivaldi-stable.desktop";
    "x-scheme-handler/spotify" = "spotify.desktop";

    # File manager and terminal
    "inode/directory" = "io.github.soyeb_jim285.HyprFM.desktop";
    "application/x-terminal-emulator" = "com.mitchellh.ghostty.desktop";

    # Images
    "image/jpeg" = "imv.desktop";
    "image/png" = "imv.desktop";
    "image/gif" = "imv.desktop";
    "image/webp" = "imv.desktop";
    "image/svg+xml" = "imv.desktop";
    "image/avif" = "imv.desktop";
    "image/bmp" = "imv.desktop";
    "image/tiff" = "imv.desktop";
    "image/*" = "imv.desktop";

    # Video
    "video/mp4" = "vlc.desktop";
    "video/x-matroska" = "vlc.desktop";
    "video/webm" = "vlc.desktop";
    "video/ogg" = "vlc.desktop";
    "video/quicktime" = "vlc.desktop";
    "video/*" = "vlc.desktop";

    # Audio (local playback; stream links stay with Spotify)
    "audio/mpeg" = "vlc.desktop";
    "audio/ogg" = "vlc.desktop";
    "audio/flac" = "vlc.desktop";
    "audio/wav" = "vlc.desktop";
    "audio/x-m4a" = "vlc.desktop";
    "audio/mp4" = "vlc.desktop";
    "audio/*" = "vlc.desktop";

    # Documents
    "application/pdf" = "zotero.desktop";
    "text/plain" = "nvim.desktop";
    "text/csv" = [
      "onlyoffice-desktopeditors.desktop"
      "calc.desktop"
    ];
    "text/markdown" = "obsidian.desktop";

    # Office: OnlyOffice primary, LibreOffice as fallback
    "application/msword" = [
      "onlyoffice-desktopeditors.desktop"
      "writer.desktop"
    ];
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = [
      "onlyoffice-desktopeditors.desktop"
      "writer.desktop"
    ];
    "application/vnd.ms-excel" = [
      "onlyoffice-desktopeditors.desktop"
      "calc.desktop"
    ];
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = [
      "onlyoffice-desktopeditors.desktop"
      "calc.desktop"
    ];
    "application/vnd.ms-powerpoint" = [
      "onlyoffice-desktopeditors.desktop"
      "impress.desktop"
    ];
    "application/vnd.openxmlformats-officedocument.presentationml.presentation" = [
      "onlyoffice-desktopeditors.desktop"
      "impress.desktop"
    ];
    "application/vnd.oasis.opendocument.text" = [
      "onlyoffice-desktopeditors.desktop"
      "writer.desktop"
    ];
    "application/vnd.oasis.opendocument.spreadsheet" = [
      "onlyoffice-desktopeditors.desktop"
      "calc.desktop"
    ];
    "application/vnd.oasis.opendocument.presentation" = [
      "onlyoffice-desktopeditors.desktop"
      "impress.desktop"
    ];

    # Mail and conferencing
    "x-scheme-handler/mailto" = "org.gnome.Geary.desktop";
    "x-scheme-handler/zoommtg" = "zoom.desktop";
    "x-scheme-handler/msteams" = "teams-for-linux.desktop";

    # App-specific schemes
    "x-scheme-handler/obsidian" = "obsidian.desktop";
    "x-scheme-handler/bitwarden" = "bitwarden.desktop";
  };

  # Rename and tidy audio sinks via WirePlumber rules.
  # See https://pipewire.pages.freedesktop.org/wireplumber/daemon/configuration/alsa.html
  xdg.configFile."wireplumber/wireplumber.conf.d/50-rename-audio.conf".text = ''
    monitor.alsa.rules = [
      {
        matches = [{ node.name = "~alsa_output.pci-0000_*_00.6.analog-stereo" }]
        actions = {
          update-props = {
            node.description = "Speakers"
          }
        }
      }
      {
        matches = [{ node.name = "~alsa_output.pci-0000_*_00.1.pro-output-3" }]
        actions = {
          update-props = {
            node.description = "HDMI/DP"
          }
        }
      }
      {
        matches = [
          { node.name = "~alsa_output.pci-0000_*_00.1.pro-output-7" }
          { node.name = "~alsa_output.pci-0000_*_00.1.pro-output-8" }
          { node.name = "~alsa_output.pci-0000_*_00.1.pro-output-9" }
        ]
        actions = {
          update-props = {
            node.disabled = true
          }
        }
      }
    ]
  '';

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # };
}
