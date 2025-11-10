{
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
        legacyPackages.homeConfigurations.default =
          inputs.home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [ ./home.nix ];
            extraSpecialArgs = { inherit inputs; };
          };

        # Call `nix run` to apply your Home Manager configuration.
        packages.default =
          pkgs.writeShellScriptBin "dotfiles-apply" ''
            exec ${pkgs.home-manager}/bin/home-manager --flake .#default switch
          '';
      };
    };
}
