{ config, pkgs, ... }:
{
  programs.r = {

    enable = true;
    packages = with pkgs.rPackages; [
      ggplot2
      dplyr
      rtracklayer
      DESeq2
      apeglm
      GenomicRanges
      tidyr

    ];
  };

}
