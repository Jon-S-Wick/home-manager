{ inputs, pkgs, ... }:
{
  home.packages = [ inputs.monique.packages.${pkgs.system}.default ];
  # imports = [ inputs.monique.nixosModules.default ];
  # programs.monique.enable = true;

  systemd.user.services.moniqued = {
    Unit = {
      Description = "Monique - monitor hotplug daemon";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${inputs.monique.packages.${pkgs.system}.default}/bin/moniqued";
      Restart = "on-failure";
      RestartSec = 5;
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
