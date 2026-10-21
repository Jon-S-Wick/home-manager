# Hypridle is a daemon that listens for user activity and runs commands when the user is idle.
{ ... }:
{
  services.hypridle = {
    enable = true;
    settings = {

      general = {
        ignore_dbus_inhibit = false;
        ignore_systemd_inhibit = false;
        lock_cmd = "noctalia msg session lock";
        before_sleep_cmd = "loginctl lock-session";
        # Only wake the outputs here. Do NOT `hyprctl reload` on resume: the previous
        # "dpms on; reload; sleep 3; reload" re-applied monitor rules while outputs were
        # still being torn down, which crashed Hyprland 0.56.2 inside
        # CMonitor::applyMonitorRule -> Aquamarine CDRMAtomicRequest::planeProps.
        # moniqued already re-applies the monitor profile on resume.
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 600;
          on-timeout = "noctalia msg session lock";
        }

        {
          timeout = 660;
          on-timeout = "chvt 63 && systemctl suspend";
        }
      ];
    };
  };
}
