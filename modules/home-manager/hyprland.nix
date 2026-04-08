{pkgs, ...}:
{
    wayland.windowManager.hyprland = {
        enable = true;
        package = null;
        portalPackage = null;

        systemd.variables = ["--all"];

    };



    home.pointerCursor = {
        gtk.enable = true;
        # x11.enable = true;
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 16;
    };

    gtk = {
        enable = true;

        theme = {
            package = pkgs.orchis-theme;
            name = "Orchis-Purple-Dark";
        };

        iconTheme = {
            package = pkgs.adwaita-icon-theme;
            name = "Adwaita";
        };

        font = {
            name = "JetBrains Mono";
            size = 11;
        };
    };

    qt = {
        enable = true;
        #platformTheme.name = "gtk";
    };

    wayland.windowManager.hyprland.settings = {

        monitor = [
            ",preferred,auto,auto"
            "HDMI-A-1, 1920x1080@144, 0x0, 1"
            "HDMI-A-2, 1920x1080@60, -1920x0, 1" ];
        env = [
            "TERM,kitty"
            #"XCURSOR_SIZE,24"
            "HYPRCURSOR_THEME,Bibata-Modern-Ice"
            "HYPRCURSOR_SIZE,24"
        ];
        exec-once = [ 
            "uwsm app -- hyprpaper"
            "[workspace 2 silent] uwsm app -- zen"
            "uwsm app -- nm-applet"
            #"uwsm app -- hypridle"
            "wl-paste --watch cliphist store &"
            "wl-paste --type text --watch cliphist store"
            "wl-paste --type image --watch cliphist store"
            "exec-once = uwsm app -- hyprctl setcursor Bibata-Modern-Ice 24"

        ];

        "$terminal" = "uwsm app -- kitty";
        "$fileManager" = "uwsm app -- thunar";
        "$menu" = "wofi --show drun";
        
        cursor = {
            no_hardware_cursors = "true";
        };

        input = {
            kb_layout = "de";
            kb_variant = "";
            kb_model = "";
            kb_options = "caps:escape";
            kb_rules = "";

            follow_mouse = 1;

            touchpad = {
                natural_scroll = "no";
            };

            sensitivity = "0"; # -1.0 to 1.0, 0 means no modification.
            accel_profile = "flat";
        };


        general = {
            # See https://wiki.hyprland.org/Configuring/Variables/ for more

            gaps_in = 2;
            gaps_out = 5;
            border_size = 2;
            "col.active_border" = "rgba(4077b2ed) rgba(40b0b2ed) 45deg";
            "col.inactive_border" = "rgba(595959aa)";

            layout = "dwindle";

# Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
            allow_tearing = "true";
        };


        animation = [
          "windows, 1, 5, myBezier, popin 80%"
            "windowsMove, 1, 4, easeOut, slide"
            "windowsIn, 1, 5, easeOut, popin 85%"
            "windowsOut, 1, 4, easeOut, popin 85%"
            "fadeIn, 1, 4, easeOut"
            "fadeOut, 1, 3, easeOut"
            "workspaces, 1, 5, easeOut, slide"
            "workspacesIn, 1, 4, easeOut, slidefade 10%"
            "workspacesOut, 1, 4, easeOut, slidefade 10%"
            "specialWorkspace, 1, 5, easeOut, slidefadevert 10%"
            "specialWorkspaceIn, 1, 4, easeOut, slidefadevert 10%"
            "specialWorkspaceOut, 1, 4, easeOut, slidefadevert 10%"
            "layers, 1, 4, easeOut, slide"
            "layersIn, 1, 4, easeOut, slidefade 15%"
            "layersOut, 1, 3, easeOut, slidefade 15%"
            "border, 1, 3, easeOut"
            "borderangle, 1, 15, easeOut, once"
            "fadeDim, 1, 4, easeOut"
            "fadeLayers, 1, 4, easeOut"
        ];

        bezier = [
          "myBezier, 0.05, 0.9, 0.1, 1.05"
            "easeOut, 0.22, 1, 0.36, 1"
        ];

# ── Decoration ──────────────────────────────────────────
        decoration = {
          rounding = 5;
          active_opacity = 1.0;
          inactive_opacity = 1.0;
          fullscreen_opacity = 1.0;

          shadow = {
            enabled = true;
            range = 12;
            render_power = 3;
            color = "rgba(00000055)";
            color_inactive = "rgba(00000000)";
          };

          blur = {
            enabled = true;
            size = 6;
            passes = 3;
            noise = 0.02;
            contrast = 1.1;
            brightness = 1.0;
            vibrancy = 0.2;
            vibrancy_darkness = 0.5;
            special = true;
            popups = true;
            popups_ignorealpha = 0.6;
          };
          dim_inactive = true;
          dim_strength = 0.1;
          dim_special = 0.3;
          dim_around = 0.5;
        };

# ── Misc ────────────────────────────────────────────────
        misc = {
          animate_manual_resizes = true;
          animate_mouse_windowdragging = true;
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
        };

        dwindle = {
            # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
            pseudotile = true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
            preserve_split = true; # you probably want this
        };

        master = {
            new_on_top = "true";
        };

    };

    wayland.windowManager.hyprland.extraConfig = 
        ''

#env = GDK_BACKEND,wayland,x11,*
#env = QT_QPA_PLATFORM,wayland
env = SDL_VIDEODRIVER,wayland
env = CLUTTER_BACKEND,wayland

env = SDL_VIDEO_DRIVER,wayland

env = QT_AUTO_SCREEN_SCALE_FACTOR,1

# NVIDIA Settings
env = XDG_SESSION_TYPE,wayland
env = NVD_BACKEND,direct

env = HYPRCURSOR_THEME,Bibata-Modern-Ice
env = HYPRCURSOR_SIZE,24

# Execute your favorite apps at launch

exec-once = uwsm app -- hyprctl setcursor Bibata-Modern-Ice 24

exec-once = systemctl --user start hyprpolkitagent

# Set programs that you use

# Some default env vars.
env = QT_QPA_PLATFORMTHEME,qt6ct # change to qt6ct if you have that

# For all categories, see https://wiki.hyprland.org/Configuring/Variables/

# EXPERIMENTAL
render:direct_scanout = true

misc {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more
    enable_swallow = false
    swallow_regex = (foot|kitty|allacritty|Alacritty)
    disable_hyprland_logo = true
    force_default_wallpaper = 0
}

# See https://wiki.hyprland.org/Configuring/Keywords/ for more
$mainMod = SUPER

# Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
bind = $mainMod, Q, exec, $terminal
bind = $mainMod, C, killactive, 
bind = $mainMod, E, exec, $fileManager
bind = $mainMod, V, togglefloating, 
bind = $mainMod, R, exec, $menu
bind = $mainMod, P, pseudo
bind = $mainMod, J, layoutmsg, togglesplit
bind = $mainMod, H, layoutmsg, swapsplit

bind = $mainMod, F, fullscreen 

# Move focus with mainMod + arrow keys
bind = $mainMod, left, movefocus, l
bind = $mainMod, right, movefocus, r
bind = $mainMod, up, movefocus, u
bind = $mainMod, down, movefocus, d

# Switch workspaces with mainMod + [0-9]
bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5
bind = $mainMod, 6, workspace, 6
bind = $mainMod, 7, workspace, 7
bind = $mainMod, 8, workspace, 8
bind = $mainMod, 9, workspace, 9
bind = $mainMod, 0, workspace, 10

# Move active window to a workspace with mainMod + SHIFT + [0-9]
bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5
bind = $mainMod SHIFT, 6, movetoworkspace, 6
bind = $mainMod SHIFT, 7, movetoworkspace, 7
bind = $mainMod SHIFT, 8, movetoworkspace, 8
bind = $mainMod SHIFT, 9, movetoworkspace, 9
bind = $mainMod SHIFT, 0, movetoworkspace, 10

# Example special workspace (scratchpad)
bind = $mainMod, S, togglespecialworkspace, magic
bind = $mainMod SHIFT, S, movetoworkspace, special:magic

# Scroll through existing workspaces with mainMod + scroll
bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1

# Move/resize windows with mainMod + LMB/RMB and dragging
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow

# Media Keys
bindel=, XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
bindel=, XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
# bindl=, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
# l -> do stuff even when locked
# e -> repeats when key is held 
# bindle=, XF86AudioRaiseVolume, exec, vol --up
# bindle=, XF86AudioLowerVolume, exec, vol --down
#
# bindl=, XF86AudioMute, exec, amixer set Master toggle
bindl=, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
bindl=, XF86AudioPlay, exec, playerctl play-pause # the stupid key is called play , but it toggles 
bindl=, XF86AudioNext, exec, playerctl next 
bindl=, XF86AudioPrev, exec, playerctl previous
bindl=, XF86MonBrightnessUp, exec, brightnessctl set +10%
bindl=, XF86MonBrightnessDown, exec, brightnessctl set 10%-
bindl = , switch:on:Lid Switch, exec, hyprctl dispatch dpms off
bindl = , switch:off:Lid Switch, exec, hyprctl dispatch dpms on

# Clipboard binds
bind = SUPER, d, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy

bind = , PRINT, exec, hyprshot -m window -o ~/Pictures
bind = SHIFT, PRINT, exec, hyprshot -m region -o ~/Pictures


bind = , Super, exec, true
bind = Ctrl+Shift, Escape, exec, uwsm app -- $terminal btop

bind = $mainMod, L, exec, wlogout



# ######## Window rules ########


windowrule {
  name = windowrule-1
  center = on
  float = on
  match:title = ^(Open File)(.*)$
}

windowrule {
  name = windowrule-2
  center = on
  float = on
  match:title = ^(Select a File)(.*)$
}

windowrule {
  name = windowrule-3
  center = on
  float = on
  match:title = ^(Choose wallpaper)(.*)$
}

windowrule {
  name = windowrule-4
  center = on
  float = on
  match:title = ^(Open Folder)(.*)$
}

windowrule {
  name = windowrule-5
  center = on
  float = on
  match:title = ^(Save As)(.*)$
}

windowrule {
  name = windowrule-6
  center = on
  float = on
  match:title = ^(Library)(.*)$
}

windowrule {
  name = windowrule-7
  center = on
  float = on
  match:title = ^(File Upload)(.*)$
}


# Dialogs

windowrule {
  name = windowrule-8
  float = on
  move = ((monitor_w*0.5)) (70)
  size = (monitor_w*0.5) (monitor_h*0.4)
  match:class = ^(org.pulseaudio.pavucontrol)$
}


# No shadow for tiled windows
windowrule {
  name = windowrule-9
  no_shadow = on
  match:float = 0
}

windowrule {
    name = cs2
    immediate = true
    fullscreen = true
    match:class = ^(cs2)$
  }



        '';

    programs.hyprlock = {
        enable = true;
        extraConfig = ''
# BACKGROUND
background {
    monitor =
    path = ~/nixos/modules/home-manager/hyprlock.png
    blur_passes = 2
    contrast = 0.8916
    brightness = 0.8172
    vibrancy = 0.1696
    vibrancy_darkness = 0.0
}

# GENERAL
general {
    no_fade_in = false
    grace = 0
    disable_loading_bar = false
}

# INPUT FIELD
input-field {
    monitor =
    size = 250, 60
    outline_thickness = 2
    dots_size = 0.2 # Scale of input-field height, 0.2 - 0.8
    dots_spacing = 0.2 # Scale of dots' absolute size, 0.0 - 1.0
    dots_center = true
    outer_color = rgba(0, 0, 0, 0)
    inner_color = rgba(100, 114, 125, 0.4)
    font_color = rgb(200, 200, 200)
    fade_on_empty = false
    font_family = SF Pro Display Bold
    placeholder_text = <i><span foreground="##ffffff99">Enter Pass</span></i>
    hide_input = false
    position = 0, -225
    halign = center
    valign = center
}

# Time
label {
    monitor =
    text = cmd[update:1000] echo "<span>$(date +"%H:%M")</span>"
    color = rgba(216, 222, 233, 0.70)
    font_size = 130
    font_family = SF Pro Display Bold
    position = 0, 240
    halign = center
    valign = center
}

# Day-Month-Date
label {
    monitor =
    text = cmd[update:1000] echo -e "$(date +"%A, %d %B")"
    color = rgba(216, 222, 233, 0.70)
    font_size = 30
    font_family = SF Pro Display Bold
    position = 0, 105
    halign = center
    valign = center
}



# USER
label {
    monitor =
    text = Hi, $USER
    color = rgba(216, 222, 233, 0.70)
    font_size = 25
    font_family = SF Pro Display Bold
    position = 0, -130
    halign = center
    valign = center
}

# CURRENT SONG
label {
    monitor =
    text = cmd[update:1000] echo "$(~/.config/hypr/Scripts/songdetail.sh)" 
    color = rgba(255, 255, 255, 0.7)
    font_size = 18
    font_family = JetBrains Mono Nerd, SF Pro Display Bold
    position = 0, 60
    halign = center
    valign = bottom
}
        '';
    };

    services.hyprpaper = {
        enable = true;
        settings = {
            preload = ["~/nixos/modules/home-manager/nixos.png"];
            wallpaper = [
                "HDMI-A-1,~/nixos/modules/home-manager/nixos.png"
                "HDMI-A-2,~/nixos/modules/home-manager/nixos.png"
                "LVDS-1,~/nixos/modules/home-manager/nixos.png"
            ];
            splash = false;
        };
    };

    services.hypridle = {
        enable = true;
        settings = {
            general = {
                lock_cmd = "pidof hyprlock || hyprlock";
                before_sleep_cmd = "loginctl lock-session";
                after_sleep_cmd = "hyprctl dispatch dpms on";
            };

            listener = [
            {
              timeout = 150;                                # 2.5min.
                on-timeout = "brightnessctl -s set 10";         # set monitor backlight to minimum, avoid 0 on OLED monitor.
                on-resume = "brightnessctl -r";               # monitor backlight restore.
            }
            {
              timeout = 150;
              on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0";
              on-resume = "brightnessctl -rd rgb:kbd_backlight";
            }
            {
              timeout = 300;
              on-timeout = "loginctl lock-session";
            }
            {
              timeout = 420;
              on-timeout = "hyprctl dispatch dpms off";
              on-resume = "hyprctl dispatch dpms on";
            }
            {
              timeout = 600;
              on-timeout = "systemctl suspend";
            }
            ];
        };
    };
}
