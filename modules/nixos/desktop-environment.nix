{ config, pkgs, ...}:
{
    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
        withUWSM = true;
    };

    environment.sessionVariables = {
        WLR_NO_HARDWARE_CURSOR = "1";
        NIXOS_OZONE_WL = "1";
    };

    hardware = {
        graphics.enable = true;

        nvidia.modesetting.enable = true;
    };

    nixpkgs.config.permittedInsecurePackages = [
        "qtwebengine-5.15.19"
    ];

    environment.systemPackages = [
        # Default Software
        pkgs.firefox
        pkgs.vesktop  
        pkgs.btop
        pkgs.kdePackages.ark
        pkgs.kdePackages.kcalc
        pkgs.neofetch
        pkgs.obsidian

        # DE
        pkgs.waybar
        pkgs.kitty
        pkgs.networkmanagerapplet
        pkgs.cliphist
        pkgs.rofi
        pkgs.uwsm
        pkgs.swaynotificationcenter
        pkgs.wlogout
        pkgs.wl-clipboard
        pkgs.pavucontrol
        pkgs.playerctl
        pkgs.hyprpolkitagent
        pkgs.hyprshot

        pkgs.hyprpaper
        pkgs.hyprlock
        pkgs.hypridle

        # Themes
        pkgs.sddm-astronaut

        # Extra Software
        pkgs.jellyflix
        pkgs.jellyfin-tui
    ];


    

    fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        meslo-lgs-nf
    ];

    programs.thunar.enable = true;
    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;

    xdg.portal.enable = true;
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];

    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
    };
}
