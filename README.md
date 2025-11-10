# Home Manager flake example

Example of using [Home Manager] with [Nix flakes].

[Home Manager]: https://github.com/nix-community/home-manager
[Nix flakes]: https://wiki.nixos.org/wiki/Flakes

## Setup

Copy `flake.nix` and `home.nix` into your dotfiles repository (or any directory
of your choice) and then address the todos in `home.nix`.

## Usage

After making changes to `home.nix`, run this command in the directory where your
`flake.nix` file is to apply them to your `$HOME`:

```
$ nix run
```

It might take a minute the first time you run this; Nix needs to download
dependencies and create a `flake.lock` file.
