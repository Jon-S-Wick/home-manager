{ config, pkgs, ... }: {
  # programs.r.enable = true;

  home.packages = with pkgs.rPackages; [
    ggplot2
    dplyr
    tidyr

  ];
}
