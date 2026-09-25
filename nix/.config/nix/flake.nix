{
  description = "Nix packages for Void Linux";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      packages.${system} = {
        default = pkgs.buildEnv {
          name = "user-packages";
          paths = import ./packages.nix {
            inherit pkgs inputs;
          };
        };
      };
    };
}
