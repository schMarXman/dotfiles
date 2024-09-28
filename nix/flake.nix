{
  description = "Flakey";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, ... }@inputs:
  let
	system = "x86_64-linux";
  	pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    nixosConfigurations.T495s = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/T495s/configuration.nix
	nixos-hardware.nixosModules.lenovo-thinkpad-t495
      ];
    };
    homeConfigurations."fabian" = home-manager.lib.homeManagerConfiguration {
	    inherit pkgs;
	    modules = [ ./users/fabian/home.nix ];
    };
  };
}
