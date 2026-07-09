{
  imports = [
    # ./Rlang.nix
    ./fzf.nix
    ./zsh.nix
    ./starship.nix
    ./zoxide.nix
    ./tmux.nix
    ./eza.nix
    ./kitty.nix

  ];
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    installVimSyntax = true;
    settings = {
      theme = "Gruvbox Dark";
      keybind = [
        "ctrl+enter=ignore"

        # "ctrl+h=goto_split:left"
        # "ctrl+l=goto_split:right"
      ];
    };
  };
}
