{ config, ... }:
let
  animationSpeed = config.var.theme.animation-speed;

  animationDuration = if animationSpeed == "slow" then
    4.0
  else if animationSpeed == "medium" then
    2.5
  else
    1.5;
  borderDuration = if animationSpeed == "slow" then
    10.0
  else if animationSpeed == "medium" then
    6.0
  else
    3.0;

  curves = [
    { name = "linear"; points = [[ 0 0 ] [ 1 1 ]]; }
    { name = "md3_standard"; points = [[ 0.2 0 ] [ 0 1 ]]; }
    { name = "md3_decel"; points = [[ 0.05 0.7 ] [ 0.1 1 ]]; }
    { name = "md3_accel"; points = [[ 0.3 0 ] [ 0.8 0.15 ]]; }
    { name = "overshot"; points = [[ 0.05 0.9 ] [ 0.1 1.1 ]]; }
    { name = "crazyshot"; points = [[ 0.1 1.5 ] [ 0.76 0.92 ]]; }
    { name = "hyprnostretch"; points = [[ 0.05 0.9 ] [ 0.1 1.0 ]]; }
    { name = "menu_decel"; points = [[ 0.1 1 ] [ 0 1 ]]; }
    { name = "menu_accel"; points = [[ 0.38 0.04 ] [ 1 0.07 ]]; }
    { name = "easeInOutCirc"; points = [[ 0.85 0 ] [ 0.15 1 ]]; }
    { name = "easeOutCirc"; points = [[ 0 0.55 ] [ 0.45 1 ]]; }
    { name = "easeOutExpo"; points = [[ 0.16 1 ] [ 0.3 1 ]]; }
    { name = "softAcDecel"; points = [[ 0.26 0.26 ] [ 0.15 1 ]]; }
    { name = "md2"; points = [[ 0.4 0 ] [ 0.2 1 ]]; }
  ];

  animations = [
    { leaf = "windows"; speed = animationDuration; bezier = "md3_decel"; style = "popin 60%"; }
    { leaf = "windowsIn"; speed = animationDuration; bezier = "md3_decel"; style = "popin 60%"; }
    { leaf = "windowsOut"; speed = animationDuration; bezier = "md3_accel"; style = "popin 60%"; }
    { leaf = "border"; speed = borderDuration; bezier = "default"; }
    { leaf = "fade"; speed = animationDuration; bezier = "md3_decel"; }
    { leaf = "layersIn"; speed = animationDuration; bezier = "menu_decel"; style = "slide"; }
    { leaf = "layersOut"; speed = animationDuration; bezier = "menu_accel"; }
    { leaf = "fadeLayersIn"; speed = animationDuration; bezier = "menu_decel"; }
    { leaf = "fadeLayersOut"; speed = animationDuration; bezier = "menu_accel"; }
    { leaf = "workspaces"; speed = animationDuration; bezier = "menu_decel"; style = "slide"; }
    { leaf = "specialWorkspace"; speed = animationDuration; bezier = "md3_decel"; style = "slidevert"; }
  ];
in {
  wayland.windowManager.hyprland.settings = {
    curve = map (c: {
      _args = [
        c.name
        {
          type = "bezier";
          points = c.points;
        }
      ];
    }) curves;

    animation = map (a: a // { enabled = true; }) animations;
  };
}
