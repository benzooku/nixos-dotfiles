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
        platformTheme.name = "gtk";
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
            "[workspace 2 silent] uwsm app -- firefox"
            "uwsm app -- nm-applet"
            #"uwsm app -- hypridle"
            "wl-paste --watch cliphist store &"
            "wl-paste --type text --watch cliphist store"
            "wl-paste --type image --watch cliphist store"
            "exec-once = uwsm app -- hyprctl setcursor Bibata-Modern-Ice 24"

        ];

        "$terminal" = "uwsm app -- kitty";
        "$fileManager" = "uwsm app -- thunar";
        "$menu" = "uwsm app -- ~/.config/rofi/launchers/type-5/launcher.sh";
        
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


        decoration = {
            # See https://wiki.hyprland.org/Configuring/Variables/ for more

            rounding = 2;

            blur = {
                enabled = "true";
                xray = true;
                special = "false";
                new_optimizations = "true";
                size = 14;
                passes = 2;
                brightness = 1;
                noise = 0.01;
                contrast = 1;
                popups = "true";
                popups_ignorealpha = "0.6";
            };

        };


        animations = {
            enabled = "true";

            bezier = [ "linear, 0, 0, 1, 1"
                "md3_standard, 0.2, 0, 0, 1"
                "md3_decel, 0.05, 0.7, 0.1, 1"
                "md3_accel, 0.3, 0, 0.8, 0.15"
                "overshot, 0.05, 0.9, 0.1, 1.1"
                "crazyshot, 0.1, 1.5, 0.76, 0.92"
                "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
                "menu_decel, 0.1, 1, 0, 1"
                "menu_accel, 0.38, 0.04, 1, 0.07"
                "easeInOutCirc, 0.85, 0, 0.15, 1"
                "easeOutCirc, 0, 0.55, 0.45, 1"
                "easeOutExpo, 0.16, 1, 0.3, 1"
                "softAcDecel, 0.26, 0.26, 0.15, 1"
                "md2, 0.4, 0, 0.2, 1" # use with .2s duration
            ];
            animation = ["windows, 1, 3, md3_decel, popin 60%"
                "windowsIn, 1, 3, md3_decel, popin 60%"
                "windowsOut, 1, 3, md3_accel, popin 60%"
                "border, 1, 10, default"
                "fade, 1, 3, md3_decel"
                "layersIn, 1, 3, menu_decel, slide"
                "layersOut, 1, 1.6, menu_accel"
                "fadeLayersIn, 1, 2, menu_decel"
                "fadeLayersOut, 1, 4.5, menu_accel"
                "workspaces, 1, 7, menu_decel, slide"
                "specialWorkspace, 1, 3, md3_decel, slidevert"
            ];
        };


        dwindle = {
            # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
            pseudotile = "yes"; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
            preserve_split = "yes"; # you probably want this
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

env = __NV_PRIME_RENDER_OFFLOAD,1
env = __VK_LAYER_NV_optimus,NVIDIA_only

env = QT_AUTO_SCREEN_SCALE_FACTOR,1

# NVIDIA Settings
env = LIBVA_DRIVER_NAME,nvidia
env = GBM_BACKEND,nvidia-drm

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




misc {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more
    force_default_wallpaper = 1 # Set to 0 or 1 to disable the anime mascot wallpapers
    animate_manual_resizes = false
    animate_mouse_windowdragging = false
    enable_swallow = false
    swallow_regex = (foot|kitty|allacritty|Alacritty)
    disable_hyprland_logo = true
    force_default_wallpaper = 0
    new_window_takes_over_fullscreen = 2
}

# See https://wiki.hyprland.org/Configuring/Keywords/ for more
$mainMod = SUPER

# Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
bind = $mainMod, Q, exec, $terminal
bind = $mainMod, C, killactive, 
bind = $mainMod, E, exec, $fileManager
bind = $mainMod, V, togglefloating, 
bind = $mainMod, R, exec, $menu
bind = $mainMod, P, pseudo, # dwindle
bind = $mainMod, J, togglesplit, # dwindle
bind = $mainMod, H, swapsplit

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

# Clipboard binds
bind = SUPER, d, exec, pkill rofi || cliphist list | rofi --no-fuzzy --dmenu | cliphist decode | wl-copy

bind = , PRINT, exec, hyprshot -m window -o ~/Pictures
bind = SHIFT, PRINT, exec, hyprshot -m region -o ~/Pictures


bind = , Super, exec, true
bind = Ctrl+Shift, Escape, exec, uwsm app -- $terminal btop

bind = $mainMod, L, exec, wlogout



# ######## Window rules ########

windowrule = center, title:^(Open File)(.*)$
windowrule = center, title:^(Select a File)(.*)$
windowrule = center, title:^(Choose wallpaper)(.*)$
windowrule = center, title:^(Open Folder)(.*)$
windowrule = center, title:^(Save As)(.*)$
windowrule = center, title:^(Library)(.*)$
windowrule = center, title:^(File Upload)(.*)$

# Dialogs
windowrule=float,title:^(Open File)(.*)$
windowrule=float,title:^(Select a File)(.*)$
windowrule=float,title:^(Choose wallpaper)(.*)$
windowrule=float,title:^(Open Folder)(.*)$
windowrule=float,title:^(Save As)(.*)$
windowrule=float,title:^(Library)(.*)$
windowrule=float,title:^(File Upload)(.*)$

windowrule=float,class:^(org.pulseaudio.pavucontrol)$
windowrule=move 50% 70,class:^(org.pulseaudio.pavucontrol)$
windowrule=size 50% 40%,class:^(org.pulseaudio.pavucontrol)$

# No shadow for tiled windows
windowrulev2 = noshadow,floating:0

# ######## Layer rules ########
layerrule = xray 1, .*
layerrule = blur, notifications
layerrule = ignorealpha 0.69, notifications

layerrule = blur, overview
layerrule = ignorealpha 0.6, overview
layerrule = blur, sideright
layerrule = ignorealpha 0.6, sideright

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
            preload = ["~/Pictures/wallpapers/temple.png" "~/nixos/modules/home-manager/nixos.png"];
            wallpaper = [
                "HDMI-A-1,~/nixos/modules/home-manager/nixos.png"
                "HDMI-A-2,~/nixos/modules/home-manager/nixos.png"
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
                    on-timeput = "brightnessctl -sd rgb:kbd_backlight set 0";
                    on-resume = "brightnessctl -rd rgb:kbd_backlight";
                }
                {
                    timeout = 300;
                    on-timeout = "loginctl lock-session";
                }
            ];
        };
    };
}
