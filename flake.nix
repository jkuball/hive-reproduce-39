{
  outputs =
    { self
    , hive
    , ...
    } @ inputs:
    hive.growOn
      {
        inherit inputs;
        cellsFrom = ./cells;
        cellBlocks =
          let
            inherit (hive.inputs) std;
            blockTypes = std.blockTypes // hive.blockTypes;
          in
          with blockTypes; [
            nixosConfigurations
          ];
      }
      {
        nixosConfigurations = hive.collect self "nixosConfigurations";
      };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    hive.url = "github:divnix/hive";
    hive.inputs.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };
}
