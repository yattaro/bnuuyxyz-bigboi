{
  description = "bnuuy.xyz basic config";

  inputs = {
    /*lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.3-1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };*/
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, /*lix-module,*/ ... }@inputs: {
    nixosConfigurations = {
      bnuuyxyz-bigboi = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/bnuuyxyz-bigboi
          ./users/yattaro/user-config.nix
          ./modules/common-packages.nix
          # lix-module.nixosModules.default
        ];
      };
    };
  };
}
