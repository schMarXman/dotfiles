{ ... }: 

{
	services.syncthing = {
		enable = true;
		# TODO change to vars
		user = "fabian";
		group = "users";
		dataDir = "/home/fabian";
	};
	networking.firewall.allowedTCPPorts = [ 8384 22000 ];
	networking.firewall.allowedUDPPorts = [ 22000 21027 ];
}
