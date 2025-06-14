{
  inputs,
  pkgs,
  ...
}:

{
home.username = "jonwick";
  home.homeDirectory = "/home/jonwick";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
  # imports = [
  #   ./theming.nix
  #   # ./settings.nix
  #
  #   ./programs/thunar.nix
  #   ./programs/hyprland/default.nix
  #   ./var.nix
  #   ./programs/shell/default.nix
  #   ./programs/wofi/default.nix
  #   ./scripts/default.nix
  #   # ./programs/nvim/default.nix
  #   ./programs/dunst/default.nix
  #   # ./programs/wofi/cider.nix
  #   # ./programs/waybar/default.nix
  #   ./scripts/default.nix
  #   ./programs/clipman.nix
  #
  #   ./programs/spicetify.nix
  #   # inputs.spicetify-nix.homeManagerModules.default
  #
  # ];
  #   # config = {
  # # Home Manager needs a bit of information about you and the paths it should
  # # manage.
  #
  # stylix.targets.mako.enable = false;
  #
  # home.username = "jonwick";
  # home.homeDirectory = "/home/jonwick";
  # services.network-manager-applet.enable = true;
  # nixpkgs.config.allowUnfree = true;
  # # services.xserver = {
  # #     enable = true;
  # #   };
  #
  # # This value determines the Home Manager release that your configuration is
  # # compatible with. This helps avoid breakage when a new Home Manager release
  # # introduces backwards incompatible changes.
  # #
  # # You should not change this value, even if you update Home Manager. If you do
  # # want to update the value, then make sure to first check the Home Manager
  # # release notes.
  # home.stateVersion = "24.05"; # Please read the comment before changing.
  #
  # # The home.packages option allows you to install Nix packages into your
  # # environment.
  # home.packages = [
  #   # Adds the 'hello' command to your environment. It prints a friendly
  #   # "Hello, world!" when run.
  #   # pkgs.hello
  #   pkgs.vscode
  #   pkgs.geary
  #   pkgs.iwgtk
  #   pkgs.samtools
  #   pkgs.rstudio
  #   pkgs.zotero
  #   pkgs.zoom-us
  #   # pkgs.imagej
  #   pkgs.fiji
  #   pkgs.jdt-language-server
  #   pkgs.neofetch
  #   pkgs.ghostty
  #   # inputs.ghostty.packages.x86_64-linux.default
  #   pkgs.cliphist
  #   pkgs.swappy
  #   pkgs.slurp
  #   pkgs.grimblast
  #   pkgs.spicetify-cli
  #   pkgs.texliveFull
  #   # pkgs.spotify
  #
  #   # pkgs.ghostty
  #
  #   # pkgs.cider-2
  #   # pkgs.appimageTools
  #   # pkgs.fetchurl
  #   # pkgs.lib
  #   # # It is sometimes useful to fine-tune packages, for example, by applying
  #   # # overrides. You can do that directly here, just don't forget the
  #   # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
  #   # # fonts?
  #   # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
  #
  #   # # You can also create simple shell scripts directly inside your
  #   # # configuration. For example, this adds a command 'my-hello' to your
  #   # # environment:
  #   # (pkgs.writeShellScriptBin "my-hello" ''
  #   #   echo "Hello, ${config.home.username}!"
  #   # '')
  # ];
  # # programs.neovim = {
  # #   enable = true;
  # #   extraPackages = with pkgs; [
  # #     vimPlugins.mini-base16
  # #     # Formatters
  # #     gofumpt
  # #     goimports-reviser
  # #     golines
  # #
  # #     # LSP
  # #     gopls
  # #     jdt-language-server
  # #     pyright
  # #
  # #     # Tools
  # #     go
  # #     gcc
  # #   ];
  # # };
  #
  # # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # # plain files is through 'home.file'.
  # home.file = {
  #   # # Building this configuration will create a copy of 'dotfiles/screenrc' in
  #   # # the Nix store. Activating the configuration will then make '~/.screenrc' a
  #   # # symlink to the Nix store copy.
  #   # ".screenrc".source = dotfiles/screenrc;
  #
  #   # # You can also set the file content immediately.
  #   # ".gradle/gradle.properties".text = ''
  #   #   org.gradle.console=verbose
  #   #   org.gradle.daemon.idletimeout=3600000
  #   # '';
  # };
  #
  # # Home Manager can also manage your environment variables through
  # # 'home.sessionVariables'. These will be explicitly sourced when using a
  # # shell provided by Home Manager. If you don't want to manage your shell
  # # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # # located at either
  # #
  # #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  # #
  # # or
  # #
  # #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  # #
  # # or
  # #
  # #  /etc/profiles/per-user/jonwick/etc/profile.d/hm-session-vars.sh
  # #
  # home.sessionVariables = {
  #   EDITOR = "nvim";
  # };
  #
  # # Let Home Manager install and manage itself.
  # programs.home-manager.enable = true;
  #   # };
}
