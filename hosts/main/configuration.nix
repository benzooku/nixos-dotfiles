{ config, pkgs, inputs, ... }:

{
    imports =
        [ 
            ./hardware-configuration.nix
            inputs.home-manager.nixosModules.default
        ];

    boot.loader.systemd-boot.enable = false;
    # Bootloader.
    boot.loader = {
        grub = {
            enable = true;
            useOSProber = true;
            device = "nodev";
            efiSupport = true;
        };
        efi = {
            canTouchEfiVariables = true;
            efiSysMountPoint = "/boot";
        };

        
    };
    boot.loader.grub2-theme = {
        enable = true;
        theme = "vimix";
        footer = true;
    };


    services.xserver.enable = true;
    services.displayManager.sddm = {
        enable = true;
        theme = "sddm-astronaut-theme";
    };

    
    nix.settings.experimental-features = ["nix-command" "flakes"];
    nix.settings = {
        max-jobs = "auto";
        http-connections = 50;
        download-attempts = 10;
        download-buffer-size = 524288000;
    };

    # Use latest kernel.
    boot.kernelPackages = pkgs.linuxPackages_latest;

    networking.hostName = "nixos"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Enable networking
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "Europe/Berlin";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "de_DE.UTF-8";
        LC_IDENTIFICATION = "de_DE.UTF-8";
        LC_MEASUREMENT = "de_DE.UTF-8";
        LC_MONETARY = "de_DE.UTF-8";
        LC_NAME = "de_DE.UTF-8";
        LC_NUMERIC = "de_DE.UTF-8";
        LC_PAPER = "de_DE.UTF-8";
        LC_TELEPHONE = "de_DE.UTF-8";
        LC_TIME = "de_DE.UTF-8";
    };

    # Configure keymap in X11
    services.xserver.xkb = {
        layout = "de";
        variant = "";
    };

    # Configure console keymap
    console.keyMap = "de";

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.ben = {
        isNormalUser = true;
        description = "Ben";
        extraGroups = [ "networkmanager" "wheel" "docker"];
        packages = with pkgs; [];
    };

    home-manager = {
        extraSpecialArgs = { inherit inputs; };
        users = {
            "ben" = import ./home.nix;
        };
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        neovim
        kitty
        git
        libva-utils
    ];

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "25.05"; # Did you read the comment?

}
