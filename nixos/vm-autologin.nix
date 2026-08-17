{ pkgs, lib, ... }:

{
  # Skip the greeter entirely - most convenient for a personal, local VM.
  services.greetd.settings.default_session = lib.mkForce {
    command = "${pkgs.uwsm}/bin/uwsm start -e -D Hyprland hyprland.desktop";
    user = "xnm";
  };
}
