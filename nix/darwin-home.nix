{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    R
    # brewCasks.vlc
    # brewCasks.rstudio
    # brewCasks.cheatsheet
    # brewCasks.mountain-duck
    # brewCasks.mqttx
    # (brewCasks.redisinsight.withConfig (cask: {
    #   srcHash = "sha256-QkH32ehLD4DIROH1hICNA+27XaZrq1CJtwz3TH9IyIA=";
    # }))
  ];
}
