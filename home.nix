{ config, inputs, lib, pkgs, ... }:

{
  # TODO: Choose the latest version from this list when you first set up Home
  # Manager, and then leave it alone thereafter.
  # https://nix-community.github.io/home-manager/options.xhtml#opt-home.stateVersion
  home.stateVersion = "25.11";

  # TODO: Change this to your username.
  home.username = "evanrelf";

  # TODO: Pick one of these depending on your OS.
  home.homeDirectory = "/Users/${config.home.username}"; # macOS
  # home.homeDirectory = "/home/${config.home.username}"; # Linux

  home.packages = with pkgs; [
    # TODO: List the packages you want installed here.
    home-manager
  ];
}
