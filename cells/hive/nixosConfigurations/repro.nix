{ inputs, cell }:
let
  inherit (inputs) nixpkgs;

  bee = rec {
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
  };
in
{
  inherit bee;

  imports = [
    inputs.disko.nixosModules.disko
    inputs.nixos-facter-modules.nixosModules.facter
  ];

  # Needed to be a valid nixos configuration.
  boot.loader.grub.device = "nodev";
  fileSystems = {
    "/".device = "/dev/does/not/exist";
  };
}
