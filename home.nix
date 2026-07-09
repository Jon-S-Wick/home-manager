{
  inputs,
  pkgs,
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
    ./scripts/default.nix
    ./programs/clipman.nix

    ./programs/spicetify.nix
    # inputs.spicetify-nix.homeManagerModules.default

  ];
  # config = {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.

  stylix.targets.mako.enable = false;
  # stylix.targets.sddm.enable = true;

  home.username = "jonwick";
  home.homeDirectory = "/home/jonwick";
  services.network-manager-applet.enable = true;
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "openclaw-2026.6.5"
    "electron-39.8.10"

  ];

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
  home.stateVersion = "24.05"; # Please read the comment before changing.
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
      wrappedVivaldi
      pkgs.mysql-workbench
      pkgs.neovim
      pkgs.waydroid
      pkgs.morewaita-icon-theme

      pkgs.nodejs
      pkgs.ollama-cuda
      pkgs.conda
      pkgs.mamba-cpp
      pkgs.uv
      # pkgs.openclaw
      pkgs.onlyoffice-desktopeditors
      pkgs.wpsoffice-cn
      pkgs.wrangler
      pkgs.libreoffice
      pkgs.proton-vpn
      wrappedBrave
      pkgs.via
      pkgs.teams-for-linux
      pkgs.vscode
      pkgs.nerd-fonts.lilex
      pkgs.nerd-fonts.hack
      pkgs.bitwarden-desktop
      pkgs.bitwarden-cli
      pkgs.igv
      pkgs.hyprpanel
      pkgs.geary
      pkgs.iwgtk
      pkgs.samtools
      pkgs.rstudio
      pkgs.zotero
      pkgs.obsidian
      # pkgs.zoom-us
      pkgs.racket
      # pkgs.imagej
      pkgs.fiji
      pkgs.ghostty
      pkgs.adguardhome
      pkgs.vlc
      pkgs.bitwarden-menu
      pkgs.pwvucontrol
      pkgs.jdt-language-server
      pkgs.opencode
      pkgs.fastfetch
      pkgs.ghostty
      pkgs.lutris
      # inputs.ghostty.packages.x86_64-linux.default
      pkgs.cliphist
      pkgs.swappy
      pkgs.slurp
      pkgs.grimblast
      pkgs.spicetify-cli
      pkgs.texliveFull
      pkgs.texlivePackages.platex-tools

      pkgs.wpsoffice-cn

      pkgs.rPackages.rtracklayer
      pkgs.rPackages.GenomicRanges
      pkgs.rPackages.BiocGenerics
      pkgs.rPackages.IRanges
      # pkgs.R
      # pkgs.curl
      pkgs.pkg-config
      # pkgs.libxml2
      pkgs.libiconv
      pkgs.zlib
      pkgs.xz
      pkgs.bzip2
      pkgs.openssl
      # pkgs.matlab
      # optional:
      # pkgs.gcc
      # pkgs.which

      pkgs.coreutils
      pkgs.pymol
      pkgs.discord
      pkgs.python313Packages.matplotlib
      pkgs.python313Packages.seaborn
      pkgs.lunar-client

      pkgs.bun

      inputs.winapps.packages.${pkgs.system}.winapps
      inputs.winapps.packages."${pkgs.system}".winapps-launcher # optional

      # pkgs.IntaRNA
      # pkgs.spotify

      # pkgs.ghostty

      # pkgs.cider-2
      # pkgs.appimageTools
      # pkgs.fetchurl
      # pkgs.lib
      # # It is sometimes useful to fine-tune packages, for example, by applying
      # # overrides. You can do that directly here, just don't forget the
      # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # # fonts?
      # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
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
  xdg.autostart.enable = true;
  # programs.neovim = {
  #   enable = true;
  #   extraPackages = with pkgs; [
  #     vimPlugins.mini-base16
  #     # Formatters
  #     gofumpt
  #     goimports-reviser
  #     golines
  #
  #     # LSP
  #     gopls
  #     jdt-language-server
  #     pyright
  #
  #     # Tools
  #     go
  #     gcc
  #   ];
  # };

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
  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/zoommtg" = [ "zoom.desktop" ];
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
