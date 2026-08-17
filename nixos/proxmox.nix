{ ... }:

{
  # Enable QEMU guest agent for Proxmox/KVM integration
  # Allows the Proxmox host to manage the guest (shutdown, suspend, get IP, etc.)
  virtualisation.qemu.guestAgent.enable = true;
}
