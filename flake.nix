{
  description = "Example of using Home Manager with Nix flakes";

  inputs = {
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs";
    systems.url = "github:nix-systems/default";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;

      perSystem = { config, inputs', pkgs, system, ... }: {
        _module.args.pkgs = import inputs.nixpkgs { localSystem = system; };

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
      };
    };
}
