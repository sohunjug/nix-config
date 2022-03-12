{
  description = "sohunjug's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nurpkgs = {
      url = github:nix-community/NUR;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {

    nixosConfigurations."sohunjug-ls" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules =
        [
          ./hosts/sohunjug-ls/configuration.nix
        ];
    };
  };
}
