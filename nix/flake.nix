{
  description = "Flakey";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    ghostty.url = "github:ghostty-org/ghostty";

    nypkgs = { 
      url = "github:yunfachi/nypkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, nypkgs, ... }@inputs:
  let
	system = "x86_64-linux";
  	pkgs = nixpkgs.legacyPackages.${system};
	ylib = nypkgs.lib.${system};
  in
  {
    nixosConfigurations.T495s = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/T495s/configuration.nix
	nixos-hardware.nixosModules.lenovo-thinkpad-t495
      ] ++ ylib.umport { paths = [ ./nixosModules ]; };
    };
    homeConfigurations."fabian" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit inputs; };
      modules = [ 
	./users/fabian/home.nix
      ] ++ ylib.umport { paths = [ ./hmModules ]; };
    };
  };
}
