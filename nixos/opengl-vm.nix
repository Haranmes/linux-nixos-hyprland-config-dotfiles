{ ... }:

{
  # Plain Mesa/vmwgfx graphics stack for a VMware guest - no Nvidia/Intel-specific
  # VA-API packages, since there's no such hardware to drive in a VM.
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
