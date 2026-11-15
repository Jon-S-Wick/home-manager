{
  pkgs,
  inputs,
  ...
}:
{
  stylix = {
    enable = true;
    targets.hyprland.enable = true;
    targets.tmux.enable = true;
    targets.ghostty.enable = true;
    # targets.zsh.enable = false;

    # Edited catppuccin
    base16Scheme = {
      base00 = "#242120"; # Default Background
      # base01 = "#cb9168"; # Lighter Background (Used for status bars, line number and folding marks)
      base01 = "#36312f"; # Lighter Background (Used for status bars, line number and folding marks)
      base02 = "#8ba37e"; # Selection Background
      base03 = "#45475a"; # Comments, Invisibles, Line Highlighting
      base04 = "#a69680"; # Dark Foreground (Used for status bars)
      base05 = "#e5dec9"; # Default Foreground, Caret, Delimiters, Operators
      base06 = "#272423"; # Light Foreground (Not often used)
      base07 = "#b4befe"; # Light Background (Not often used)
      base08 = "#8ba37e"; # Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
      base09 = "#fab387"; # Integers, Boolean, Constants, XML Attributes, Markup Link Url
      base0A = "#f9e2af"; # Classes, Markup Bold, Search Text Background
      base0B = "#a6e3a1"; # Strings, Inherited Class, Markup Code, Diff Inserted
      base0C = "#94e2d5"; # Support, Regular Expressions, Escape Characters, Markup Quotes
      base0D = "#e0f6dd"; # Functions, Methods, Attribute IDs, Headings, Accent color
      base0E = "#cba6f7"; # Keywords, Storage, Selector, Markup Italic, Diff Changed
      base0F = "#f2cdcd"; # Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>
    };
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest.yaml";

    # override.base0C = "90c0e4"; # make teal less intense
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 20;
    };
    icons = {
      enable = true;
      package = pkgs.morewaita-icon-theme;
      light = "MoreWaita";
      dark = "MoreWaita";
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.hack;
        # name = "JetBrains Mono Nerd Font";
      };
      sansSerif = {
        package = inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system}.sf-pro-nerd;
        name = "SFProDisplay Nerd Font";
      };
      serif = {
        package = inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system}.sf-pro-nerd;
        name = "SFProDisplay Nerd Font";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 13;
        desktop = 13;
        popups = 13;
        terminal = 13;
      };
    };

    # targets.nixvim.transparentBackground = {
    #   main = true;
    #   signColumn = true;
    # };
    # targets.nixvim.plugin = "base16-nvim";
    #   polarity = "dark";
    # image = inputs.nixy-wallpapers + "/wallpapers/f.png";
    image = ./train_and_lake.png;
    targets.hyprland.hyprpaper.enable = false;
    targets.obsidian.enable = false;
  };

  # targets.kitty.enable = true;
}

# "dark": {
#     "mPrimary": "#8ba37e",
#     "mOnPrimary": "#242120",
#     "mSecondary": "#a69680",
#     "mOnSecondary": "#242120",
#     "mTertiary": "#cb9168",
#     "mOnTertiary": "#242120",
#     "mError": "#c6685d",
#     "mOnError": "#242120",
#     "mSurface": "#242120",
#     "mOnSurface": "#e5dec9",
#     "mSurfaceVariant": "#36312f",
#     "mOnSurfaceVariant": "#e5dec9",
#     "mOutline": "#665c58",
#     "mShadow": "#000000",
#     "mHover": "#8ba37e",
#     "mOnHover": "#242120",
#     "terminal": {
#       "normal": {
#         "black": "#242120",
#         "red": "#c6685d",
#         "green": "#8ba37e",
#         "yellow": "#cb9168",
#         "blue": "#67808a",
#         "magenta": "#a27886",
#         "cyan": "#769f93",
#         "white": "#e5dec9"
#       },
#       "bright": {
#         "black": "#36312f",
#         "red": "#db8177",
#         "green": "#9cb793",
#         "yellow": "#e2aa82",
#         "blue": "#809ba6",
#         "magenta": "#bc919f",
#         "cyan": "#92b9ad",
#         "white": "#f4eedc"
#       },
#       "foreground": "#e5dec9",
#       "background": "#242120",
#       "selectionFg": "#e5dec9",
#       "selectionBg": "#36312f",
#       "cursorText": "#242120",
#       "cursor": "#8ba37e"
#     }
#   },
