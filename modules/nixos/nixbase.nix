{pkgs, ...}:
{
    services.udisks2.enable = true;
    services.gvfs.enable = true;

    nix.settings.experimental-features = ["nix-command" "flakes"];
    nix.settings = {
      max-jobs = "auto";
      http-connections = 20;
      download-attempts = 10;
      download-buffer-size = 1073742000;
                            
    };

    nix = {
	    daemonCPUSchedPolicy = "idle";
	    daemonIOSchedClass = "idle";
   e
	    optimise = {
	    	automatic = true;
		dates = [ "daily" ];
	    };
    };

}
