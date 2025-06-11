{
  description = "Home Manager configuration of jonwick";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "nixpkgs/release-25.05";
    nixvim = {
      url = "github:Jon-S-Wick/nixvim";

      # url = "github:nix-community/nixvim";
      # url = "/home/gaetan/perso/nix/nixvim/nixvim";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    ghostty = {
      url = "github:ghostty-org/ghostty";
    };
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";

    nixy-wallpapers = {
      url = "github:anotherhadi/nixy-wallpapers";
      flake = false;
    };
    stylix.url = "github:danth/stylix";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
    };
  };

  outputs =
    {
      # nixpkgs,
      # ghostty,
      # spicetify-nix,
      # home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
          #   homeManagerModules.home = home-manager.lib.homeManagerConfiguration  {
          #       inherit pkgs;
          #       modules = [
          #
          # {
          #   nixpkgs.overlays = [ inputs.hyprpanel.overlay ]; # inputs.nur.overlay ];
          #   _module.args = { inherit inputs; };
          #           inherit inputs;
          # }
          # inputs.stylix.homeManagerModules.stylix
          # inputs.spicetify-nix.homeManagerModules.default
          #   ]; 
          #       extraSpecialArgs  = {inherit inputs; inherit pkgs;};
          #   };
            homeConfigurations."jonwick" = home-manager.lib.homeManagerConfiguration {
                # extraSpecialArgs = {inherit inputs; };
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [

          # {
          #   # nixpkgs.overlays = [ inputs.hyprpanel.overlay ]; # inputs.nur.overlay ];
          #   _module.args = { inherit inputs; };
          # }
          ./home.nix
          # inputs.stylix.homeManagerModules.stylix
          # inputs.spicetify-nix.homeManagerModules.default

        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
