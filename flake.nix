{
  description = "Example of using Home Manager with Nix flakes";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = inputs@{ flake-utils, nixpkgs, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        # Packaging up your Home Manager configuration.
        packages.homeConfigurations.default =
          inputs.home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [ ./home.nix ];
            extraSpecialArgs = { inherit inputs; };
          };

        # A wrapper around the `home-manager` program to point it at this flake.
        # Run it with `nix run . -- <options>`, e.g. `nix run . -- switch`.
        packages.default =
          pkgs.writeShellScriptBin "home-manager" ''
            exec ${pkgs.home-manager}/bin/home-manager --flake .#default $@
          '';
      }
    );
}
