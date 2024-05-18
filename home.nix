{ config, inputs, lib, pkgs, ... }:

{
  home.stateVersion = "24.05";

  # Change this to your username (`whoami` or `$USER`).
  home.username = "evanrelf";

  # Keep this as is if you're on macOS, or change the prefix from `/Users/` to
  # `/home/` if you're on Linux.
  home.homeDirectory = "/Users/${config.home.username}";

  home.packages = [
    pkgs.cowsay
  ];
}
