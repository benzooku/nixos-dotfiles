{ ... }:
{
  programs.hyprpanel = {
    enable = true;
    settings = {

      theme.font.name = "JetBrainsMono Nerd Font";
      theme.font.label = "JetBrainsMono Nerd Font Medium";
      theme.font.size = "0.95rem";

      menus.transition = "popin";
      scalingPriority = "gdk";

      # ── Bar layout (all monitors) ────────────────────────────
      # Each monitor gets the same clean layout
      bar.layouts = {
        "0" = {
          left = [
            "dashboard"
            "workspaces"
            "windowtitle"
          ];
          middle = [
            "media"
          ];
          right = [
            "systray"
            "cpu"
            "ram"
            "volume"
            "network"
            "clock"
            "notifications"
          ];
        };
        "1" = {
          left = [
            "dashboard"
            "workspaces"
            "windowtitle"
          ];
          middle = [
            "media"
          ];
          right = [
            "systray"
            "cpu"
            "ram"
            "volume"
            "network"
            "clock"
            "notifications"
          ];
        };
        "2" = {
          left = [
            "dashboard"
            "workspaces"
            "windowtitle"
          ];
          middle = [
            "media"
          ];
          right = [
            "systray"
            "cpu"
            "ram"
            "volume"
            "network"
            "clock"
            "notifications"
          ];
        };
      };

      # ── Bar appearance (floating, borderless) ───────────────
      theme.bar.location = "top";
      theme.bar.layer = "top";
      bar.autoHide = "never";

      # Fully transparent background — content floats on the wallpaper
      theme.bar.transparent = true;
      theme.bar.enableShadow = false;
      theme.bar.blur = 0;
      theme.bar.alpha = 0.0;

      # No border at all — clean floating bar
      theme.bar.border.location = "none";
      theme.bar.border.width = "0em";
      theme.bar.border.radius = "0.6rem";

      # Compact spacing
      theme.bar.scaling = 95;
      theme.bar.outer_spacing = "0.35rem";
      theme.bar.buttons.y_margins = "0.1rem";
      theme.bar.buttons.spacing = "0.08";
      theme.bar.buttons.padding_y = "0.12rem";
      theme.bar.buttons.innerRadiusMultiplier = "0.5";
      theme.bar.buttons.borderSize = "0em";
      theme.bar.buttons.separator.width = "0.06em";
      theme.bar.buttons.separator.margins = "0.08em";

      # Button style — subtle pill backgrounds
      theme.bar.buttons.enableBorders = false;
      theme.bar.buttons.workspaces.enableBorder = false;
      theme.bar.buttons.windowtitle.enableBorder = false;
      theme.bar.buttons.dashboard.enableBorder = false;
      theme.bar.buttons.volume.enableBorder = false;
      theme.bar.buttons.style = "compact";

      # ── Dashboard ───────────────────────────────────────────
      bar.launcher.icon = "menu";
      bar.launcher.autoDetectIcon = false;
      menus.dashboard.controls.enabled = false;
      menus.dashboard.stats.enable_gpu = false;
      menus.dashboard.shortcuts.enabled = false;
      menus.dashboard.directories.enabled = false;

      # ── Workspaces ─────────────────────────────────────────
      bar.workspaces.show_icons = true;
      bar.workspaces.show_numbered = false;
      bar.workspaces.showWsIcons = true;
      bar.workspaces.showApplicationIcons = false;
      bar.workspaces.applicationIconOncePerWorkspace = false;
      bar.workspaces.showAllActive = false;

      theme.bar.buttons.workspaces.numbered_inactive_padding = "0.3em";
      theme.bar.buttons.workspaces.numbered_active_highlight_border = "0.15em";
      theme.bar.buttons.workspaces.numbered_active_highlight_padding = "0.3em";
      theme.bar.buttons.workspaces.fontSize = "1.0em";

      # ── Window title ───────────────────────────────────────
      bar.windowtitle.custom_title = false;
      bar.windowtitle.label = true;
      bar.windowtitle.icon = false;

      # ── Media ───────────────────────────────────────────────
      bar.media.show_label = true;
      bar.media.truncation = true;
      menus.media.displayTime = false;
      menus.media.displayTimeTooltip = false;

      # ── Clock ───────────────────────────────────────────────
      bar.clock.format = "%H:%M";
      bar.clock.showIcon = false;
      bar.clock.showTime = true;
      bar.clock.showDate = false;
      menus.clock.weather.enabled = false;
      menus.clock.time.military = true;

      # ── Volume ───────────────────────────────────────────────
      bar.volume.label = false;
      menus.volume.raiseMaximumVolume = true;

      # ── Network ──────────────────────────────────────────────
      bar.network.showWifiInfo = false;
      bar.network.label = false;

      # ── CPU / RAM ───────────────────────────────────────────
      bar.customModules.ram.label = true;
      bar.customModules.ram.icon = "";
      bar.customModules.ram.round = false;
      bar.customModules.ram.labelType = "percentage";
      bar.customModules.cpu.label = true;
      bar.customModules.cpu.icon = "";
      bar.customModules.cpu.round = false;

      # ── Notifications ───────────────────────────────────────
      bar.notifications.show_total = true;
      bar.notifications.hideCountWhenZero = true;
      theme.notification.border_radius = "0.4em";
      theme.bar.menus.menu.notifications.height = "35em";

      # ── Menus ────────────────────────────────────────────────
      theme.bar.menus.monochrome = false;
      theme.bar.menus.background = "#1a1b26";
      theme.bar.menus.label = "#7aa2f7";
      theme.bar.menus.border.radius = "0.5em";
      theme.bar.menus.border.size = "0.1em";
      theme.bar.menus.buttons.radius = "0.4em";

      # ── Button colors (Tokyo Night) ──────────────────────────
      # Backgrounds are subtle pills — very dark with slight opacity
      theme.bar.buttons.background_opacity = 0;
      theme.bar.buttons.opacity = 90;
      theme.bar.buttons.monochrome = false;

      # ── Wallpaper ───────────────────────────────────────────
      wallpaper.enable = false;
      wallpaper.image = "";
      wallpaper.pywal = false;
      theme.matugen = false;
    };
  };
}
