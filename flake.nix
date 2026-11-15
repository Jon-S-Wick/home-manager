{
  description = "Home Manager configuration of jonwick";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "nixpkgs/release-25.11";
    nixvim = {
      url = "git+file:///home/jonwick/.config/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprfm.url = "github:soyeb-jim285/hyprfm";
    # torlink.url = "github:baairon/torlink";
    psysonic.url = "github:Psysonic/psysonic";

    home-manager.url = "github:nix-community/home-manager";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";

    stylix.url = "github:nix-community/stylix";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
    };
    nix-matlab = {
      # nix-matlab's Nixpkgs input follows Nixpkgs' nixos-unstable branch. However
      # your Nixpkgs revision might not follow the same branch. You'd want to
      # match your Nixpkgs and nix-matlab to ensure fontconfig related
      # compatibility.
      inputs.nixpkgs.follows = "nixpkgs";
      url = "gitlab:doronbehar/nix-matlab";
    };

    # hyprdynamicmonitors.url = "github:fiffeek/hyprdynamicmonitors";

    monique = {
      url = "github:ToRvaLDz/monique";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Upstream Hyprland main, used for wayland.windowManager.hyprland.package.
    # Hyprland 0.56.2 (latest release, latest in nixpkgs) crashes on monitor
    # teardown; the null-deref fix only exists on main. Pinned to a known-good
    # commit -- bump this by hand, don't let it float.
    hyprland = {
      url = "github:hyprwm/Hyprland/aed4830efce40190051a085653d7b297877e4068";
    };

  };

  outputs =
    {
      nixpkgs,
      # ghostty,
      spicetify-nix,
      home-manager,
      nix-matlab,
      # nixpkgs-rstudio,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          nix-matlab.overlay
        ];
      };

    in
    {
      homeManagerModules.home = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [

          {
            _module.args = { inherit inputs; };
            inherit inputs;
          }
          # home-manager >= a439f71 ships programs.noctalia itself, so
          # inputs.noctalia.homeModules.default must not be imported here.
          inputs.stylix.homeModules.stylix
          inputs.spicetify-nix.homeManagerModules.default
          inputs.hyprfm.${pkgs.system}.default
          # inputs.torlink.${pkgs.system}.default
          inputs.nixvim.packages.${pkgs.system}.nvim

          inputs.psysonic.packages.${pkgs.system}.psysonic
        ];
        extraSpecialArgs = {
          inherit inputs;
          inherit pkgs;
        };
      };
      homeConfigurations."jonwick" = home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = { inherit inputs; };
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [

          {
            _module.args = { inherit inputs; };
          }
          ./home.nix
          inputs.stylix.homeModules.stylix
          inputs.spicetify-nix.homeManagerModules.default
          # inputs.hyprdynamicmonitors.homeManagerModules.default
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
