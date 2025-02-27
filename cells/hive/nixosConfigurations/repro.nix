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

  # NOTE: The infinite recursion issue arises when you import the disko nixosModules
  #       and extend the boot.loader configuration by more options.
  imports = [
    inputs.disko.nixosModules.disko
    ({ lib, ... }: {
      options = {
        boot.loader."test".enable = lib.mkEnableOption "enable test";
      };
    })
  ];

  # Needed to be a valid nixos configuration.
  boot.loader.grub.device = "nodev";
  fileSystems = {
    "/".device = "/dev/does/not/exist";
  };
}
