{ ... }:
{
  programs.hyprpanel = {
    enable = true;
# Configure and theme almost all options from the GUI.
# See 'https://hyprpanel.com/configuration/settings.html'.
# Default: <same as gui>
    settings = {

# Configure bar layouts for monitors.
# See 'https://hyprpanel.com/configuration/panel.html'.
# Default: null

      theme.font.name = "JetBrainsMono Nerd Font";
      theme.font.label = "JetBrainsMono Nerd Font Medium";
      theme.font.size = "1rem";
      menus.transition = "crossfade";
      scalingPriority = "gdk";
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
              "battery"
              "volume"
              "network"
              "bluetooth"
              "clock"
              "notifications"
          ];
        };
      };
      theme.bar.location = "top";
      bar.autoHide = "never";
      theme.bar.buttons.enableBorders = false;
      theme.bar.border.location = "none";
      theme.bar.scaling = 100;
      theme.bar.border_radius = "0.4rem";
      theme.bar.outer_spacing = "0.5rem";
      theme.bar.buttons.y_margins = "0.2rem";
      theme.bar.buttons.radius = "0.2em";
      theme.bar.layer = "top";
      bar.launcher.icon = "";
      bar.launcher.autoDetectIcon = true;
      theme.bar.buttons.dashboard.enableBorder = false;
      theme.bar.enableShadow = false;
      theme.bar.buttons.spacing = "0.1";
      theme.bar.buttons.padding_y = "0.1rem";
      theme.bar.buttons.innerRadiusMultiplier = "0.4";
      theme.bar.border.width = "0.15em";
      theme.bar.buttons.borderSize = "0.1em";
      theme.bar.buttons.separator.width = "0.1em";
      theme.bar.buttons.separator.margins = "0.15em";
      theme.bar.buttons.workspaces.enableBorder = false;
      bar.workspaces.show_icons = false;
      bar.workspaces.show_numbered = false;
      bar.workspaces.showWsIcons = true;
      bar.workspaces.showApplicationIcons = true;
      bar.workspaces.applicationIconOncePerWorkspace = true;
      bar.workspaces.showAllActive = true;
      theme.bar.buttons.workspaces.numbered_inactive_padding = "0.2em";
      theme.bar.buttons.workspaces.numbered_active_highlight_border = "0.2em";
      theme.bar.buttons.workspaces.numbered_active_highlight_padding = "0.2em";
      theme.bar.buttons.workspaces.fontSize = "1.1em";
      theme.bar.buttons.windowtitle.enableBorder = false;
      bar.windowtitle.custom_title = true;
      bar.windowtitle.label = true;
      bar.windowtitle.icon = false;
      theme.bar.buttons.volume.enableBorder = false;
      bar.volume.label = false;
      bar.network.showWifiInfo = false;
      bar.clock.format = "%d.%m. %H:%M";
      bar.clock.showIcon = false;
      bar.clock.showTime = true;
      theme.bar.buttons.clock.spacing = "0rem";
      bar.media.show_label = true;
      bar.media.truncation = true;
      bar.notifications.show_total = true;
      bar.notifications.hideCountWhenZero = true;
      menus.media.displayTime = true;
      menus.media.displayTimeTooltip = true;
      theme.notification.border_radius = "0.5em";
      theme.bar.menus.menu.notifications.height = "58em";
      menus.volume.raiseMaximumVolume = true;
      menus.clock.time.military = true;
      menus.clock.weather.unit = "metric";
      menus.clock.weather.enabled = false;
      menus.dashboard.controls.enabled = true;
      menus.dashboard.stats.enable_gpu = false;
      menus.dashboard.shortcuts.enabled = true;
      menus.dashboard.directories.enabled = false;
      bar.customModules.ram.label = true;
      bar.customModules.ram.icon = "";
      bar.customModules.ram.round = true;
      bar.customModules.ram.labelType = "percentage";
      bar.customModules.cpu.label = true;
      bar.network.label = false;
      theme.bar.menus.monochrome = false;
      wallpaper.image = "";
      wallpaper.pywal = false;
      theme.bar.menus.background = "#11111b";
      theme.bar.menus.label = "#99c1f1";
      theme.bar.menus.border.radius = "0.3em";
      theme.bar.menus.border.size = "0.13em";
      theme.bar.menus.buttons.radius = "0.4em";
      theme.matugen = false;
      theme.matugen_settings.mode = "dark";
      theme.matugen_settings.scheme_type = "fruit-salad";
      theme.matugen_settings.variation = "standard_1";
      theme.bar.transparent = false;
      theme.bar.buttons.style = "default";
      theme.bar.border.color = "#b4befe";
      theme.bar.buttons.opacity = 100;
      theme.bar.buttons.background_opacity = 0;
      theme.bar.buttons.monochrome = false;
      wallpaper.enable = false;
    };
  };
}
