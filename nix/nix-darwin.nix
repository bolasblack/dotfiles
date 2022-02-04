{ pkgs, lib, ... }:

{
  nix.useDaemon = true;
  nix.package = pkgs.nixFlakes;
}
