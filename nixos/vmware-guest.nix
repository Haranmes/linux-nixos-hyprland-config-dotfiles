{ ... }:

{
  # Enable VMware guest integration (open-vm-tools / vmtoolsd)
  virtualisation.vmware.guest = {
    enable = true;
    # headless defaults to true when services.xserver.enable is off (Hyprland doesn't set it),
    # which would silently drop clipboard/drag-and-drop (vmblock) support. Keep it off.
    headless = false;
  };
}
