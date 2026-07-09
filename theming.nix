{
  pkgs,
  inputs,
  ...
}:
{
  stylix = {
    enable = true;
    targets.ghostty.enable = true;

    # Edited catppuccin
    # base16Scheme = {
    #   base00 = "0b0b0b"; # Default Background
    #   base01 =
    #     "1b1b1b"; # Lighter Background (Used for status bars, line number and folding marks)
    #   base02 = "2b2b2b"; # Selection Background
    #   base03 = "45475a"; # Comments, Invisibles, Line Highlighting
    #   base04 = "585b70"; # Dark Foreground (Used for status bars)
    #   base05 = "fcfcfc"; # Default Foreground, Caret, Delimiters, Operators
    #   base06 = "607ffe"; # Light Foreground (Not often used)
    #   base07 = "b4befe"; # Light Background (Not often used)
    #   base08 =
    #     "3c5a3c"; # Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
    #   base09 =
    #     "fab387"; # Integers, Boolean, Constants, XML Attributes, Markup Link Url
    #   base0A = "f9e2af"; # Classes, Markup Bold, Search Text Background
    #   base0B = "a6e3a1"; # Strings, Inherited Class, Markup Code, Diff Inserted
    #   base0C =
    #     "94e2d5"; # Support, Regular Expressions, Escape Characters, Markup Quotes
    #   base0D =
    #     "e0f6dd"; # Functions, Methods, Attribute IDs, Headings, Accent color
    #   base0E =
    #     "cba6f7"; # Keywords, Storage, Selector, Markup Italic, Diff Changed
    #   base0F =
    #     "f2cdcd"; # Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>
    # };
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest.yaml";

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
    # targets.ghostty.enable

    # targets.nixvim.transparentBackground = {
    #   main = true;
    #   signColumn = true;
    # };
    # targets.nixvim.plugin = "base16-nvim";
    #   polarity = "dark";
    # image = inputs.nixy-wallpapers + "/wallpapers/f.png";
    image = ./train_and_lake.png;
    targets.hyprland.enable = true;
    targets.hyprland.hyprpaper.enable = true;
    targets.obsidian.enable = false;
  };

  # targets.kitty.enable = true;
}
