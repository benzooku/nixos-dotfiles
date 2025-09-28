{ pkgs, ...}:
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


    environment.systemPackages = with pkgs;  [
        # Default Software
        firefox
        vesktop
        btop
        kdePackages.ark
        kdePackages.kcalc
        neofetch
        obsidian

        # DE
        hyprpanel
        kitty
        networkmanagerapplet
        cliphist
        rofi
        uwsm
        wl-clipboard
        pavucontrol
        playerctl
        hyprpolkitagent
        hyprshot

        hyprpaper
        hyprlock
        hypridle


        # Themes
        (catppuccin-sddm.override {
          flavor = "macchiato";
          accent = "mauve";
          font  = "JetBrains Mono";
          fontSize = "9";
          #background = "${./../home-manager/hyprlock.png}";
          loginBackground = true;
        })

        # Extra Software
        gimp3-with-plugins
        element-desktop

        #extra for games
        mangohud
    ];

    # steam
    programs = {
        gamescope = {
            enable = true;
            capSysNice = true;
        };
        steam = {
            enable = true;
            gamescopeSession.enable = true;
            remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
            dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
            localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
        };
    };
    hardware.xone.enable = true; # support for the xbox controller USB dongle


    fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        meslo-lgs-nf
    ];

    programs.thunar.enable = true;
    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;

    xdg.portal.enable = true;
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];

    services.gnome.gnome-keyring.enable = true;

    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
    };

    documentation.man.generateCaches = true;

}
