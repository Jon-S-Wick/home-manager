# Nixvim is a NixOS module that installs and configures Neovim
{ inputs, pkgs, ... }: {
  # let
  #   nixvim = import (builtins.fetchGit {
  #         url = "https://github.com/nix-community/nixvim";
  #         # When using a different channel you can use `ref = "nixos-<version>"` to set it here
  #                 inputs.nixpkgs.follows = "nixpkgs";
  #     });
  # in {
  imports = [
    ./options.nix
    ./keymaps.nix

    ./plugins/telescope.nix
    ./plugins/lsp.nix
    ./plugins/cmp.nix
    ./plugins/ui.nix
    ./plugins/tree.nix
    ./plugins/utils.nix
    ./plugins/dap.nix
    ./plugins/markdown.nix
    ./plugins/zenmode.nix

  ];
  programs.nixvim = {
    enable = true;

    # colorschemes.catppuccin.enable = true;
    # colorschemes.catppuccin.autoLoad = true;
    # colorscheme = "catppuccin";
    # colorschemes.catppuccin = {
    #   enable = true;
    #   flavour = "mocha";
    # };
    # extraConfigLuaPost = ''
    #   vim.cmd([[
    #     colorscheme tokyonight
    #   ]])
    # '';
    # extraConfigLuaPost = "vim.cmd [[ colorscheme nord ]]";

  };
}
