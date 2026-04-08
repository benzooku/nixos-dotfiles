{ ... }:
{
  programs.hyprpanel = {
    enable = true;
    settings = {

      theme.font.name = "JetBrainsMono Nerd Font";
      theme.font.label = "JetBrainsMono Nerd Font Medium";
      theme.font.size = "1rem";

      menus.transition = "crossfade";
      scalingPriority = "gdk";

      # ── Bar layout ──────────────────────────────────────────
      bar.layouts = {
        "0" = {
          left = [
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

      # ── Bar appearance ────────────────────────────────────
      theme.bar.location = "top";
      theme.bar.layer = "top";
      bar.autoHide = "never";

      # Frosted glass
      theme.bar.transparent = true;
      theme.bar.enableShadow = false;
      theme.bar.blur = 8;
      theme.bar.alpha = 0.85;

      # Borders & radius
      theme.bar.border.location = "all";
      theme.bar.border.width = "0.15em";
      theme.bar.border.radius = "0.5rem";
      theme.bar.border.color = "#313244";

      # Spacing
      theme.bar.scaling = 100;
      theme.bar.outer_spacing = "0.4rem";
      theme.bar.buttons.y_margins = "0.15rem";
      theme.bar.buttons.spacing = "0.1";
      theme.bar.buttons.padding_y = "0.15rem";
      theme.bar.buttons.innerRadiusMultiplier = "0.4";
      theme.bar.buttons.borderSize = "0.1em";
      theme.bar.buttons.separator.width = "0.08em";
      theme.bar.buttons.separator.margins = "0.1em";

      # Disable borders on individual buttons (clean look)
      theme.bar.buttons.enableBorders = false;
      theme.bar.buttons.workspaces.enableBorder = false;
      theme.bar.buttons.windowtitle.enableBorder = false;
      theme.bar.buttons.dashboard.enableBorder = false;
      theme.bar.buttons.volume.enableBorder = false;

      # ── Launcher ─────────────────────────────────────────
      bar.launcher.icon = "";
      bar.launcher.autoDetectIcon = true;

      # ── Workspaces ────────────────────────────────────────
      bar.workspaces.show_icons = true;
      bar.workspaces.show_numbered = false;
      bar.workspaces.showWsIcons = true;
      bar.workspaces.showApplicationIcons = true;
      bar.workspaces.applicationIconOncePerWorkspace = true;
      bar.workspaces.showAllActive = false;

      theme.bar.buttons.workspaces.numbered_inactive_padding = "0.2em";
      theme.bar.buttons.workspaces.numbered_active_highlight_border = "0.2em";
      theme.bar.buttons.workspaces.numbered_active_highlight_padding = "0.2em";
      theme.bar.buttons.workspaces.fontSize = "1.1em";

      # ── Window title ──────────────────────────────────────
      bar.windowtitle.custom_title = true;
      bar.windowtitle.label = true;
      bar.windowtitle.icon = false;

      # ── Media ─────────────────────────────────────────────
      bar.media.show_label = true;
      bar.media.truncation = true;
      menus.media.displayTime = true;
      menus.media.displayTimeTooltip = true;

      # ── Clock ─────────────────────────────────────────────
      bar.clock.format = "%H:%M";
      bar.clock.showIcon = false;
      bar.clock.showTime = true;
      bar.clock.showDate = false;
      menus.clock.time.military = true;
      menus.clock.weather.enabled = false;

      # ── Volume ─────────────────────────────────────────────
      bar.volume.label = false;
      menus.volume.raiseMaximumVolume = true;

      # ── Network ─────────────────────────────────────────────
      bar.network.showWifiInfo = false;
      bar.network.label = false;

      # ── CPU / RAM ─────────────────────────────────────────
      bar.customModules.ram.label = true;
      bar.customModules.ram.icon = "RAM";
      bar.customModules.ram.round = true;
      bar.customModules.ram.labelType = "percentage";
      bar.customModules.cpu.label = true;
      bar.customModules.cpu.icon = "CPU";
      bar.customModules.cpu.round = true;

      # ── Notifications ─────────────────────────────────────
      bar.notifications.show_total = true;
      bar.notifications.hideCountWhenZero = true;
      theme.notification.border_radius = "0.5em";
      theme.bar.menus.menu.notifications.height = "40em";

      # ── Dashboard ─────────────────────────────────────────
      menus.dashboard.controls.enabled = false;
      menus.dashboard.stats.enable_gpu = false;
      menus.dashboard.shortcuts.enabled = false;
      menus.dashboard.directories.enabled = false;

      # ── Menus theming (Catppuccin Mocha) ──────────────────
      theme.bar.menus.monochrome = false;
      theme.bar.menus.background = "#1e1e2e";
      theme.bar.menus.label = "#cdd6f4";
      theme.bar.menus.border.radius = "0.4em";
      theme.bar.menus.border.size = "0.13em";
      theme.bar.menus.buttons.radius = "0.4em";
      theme.matugen = false;

      # ── Colors (Catppuccin Mocha) ─────────────────────────
      theme.bar.menus.background = "#1e1e2e";
      theme.bar.border.color = "#313244";
      theme.bar.buttons.background_opacity = 0;
      theme.bar.buttons.opacity = 100;
      theme.bar.buttons.monochrome = false;
      theme.bar.buttons.style = "default";

      # ── Wallpaper ─────────────────────────────────────────
      wallpaper.enable = false;
      wallpaper.image = "";
      wallpaper.pywal = false;
      theme.matugen = false;
      theme.matugen_settings.mode = "dark";
    };
  };
}
