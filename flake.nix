{
  description = "sohunjug's NixOS Flake";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

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
