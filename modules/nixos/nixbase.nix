{pkgs, ...}:
{
    services.udisks2.enable = true;

    nix.settings.experimental-features = ["nix-command" "flakes"];
    nix.settings = {
      max-jobs = "auto";
      http-connections = 50;
      download-attempts = 10;
      download-buffer-size = 524288000;
    };
}
