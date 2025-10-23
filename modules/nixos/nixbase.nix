{pkgs, ...}:
{
    services.udisks2.enable = true;
    services.gvfs.enable = true;

    nix.settings.experimental-features = ["nix-command" "flakes"];
    nix.settings = {
      max-jobs = "auto";
      http-connections = 30;
      download-attempts = 10;
      download-buffer-size = 524288000;
    };

    nix = {
	    daemonCPUSchedPolicy = "idle";
	    daemonIOSchedClass = "idle";

	    optimise = {
	    	automatic = true;
		dates = [ "daily" ];
	    };
    };
}
