{
  description = "XNM's NixOS Configuration";

  inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
      systems.url = "github:nix-systems/x86_64-linux";
      wezterm.url = "github:wez/wezterm?dir=nix";
      wezterm.inputs.flake-utils.inputs.systems.follows = "systems";
      nix-ai-tools.url = "github:numtide/nix-ai-tools";
      nix-ai-tools.inputs.systems.follows = "systems";
      nix-ai-tools.inputs.blueprint.inputs.systems.follows = "systems";
      nixos-generators.url = "github:nix-community/nixos-generators";
      nixos-generators.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, ... } @ inputs:
  let
    lib = nixpkgs.lib;
    commonModules = [
      ./configuration.nix
      ./hardware-configuration.nix
      # ./fingerprint-scanner.nix
      # ./clamav-scanner.nix
      ./sound.nix
      ./keyboard.nix
      ./time.nix
      ./swap.nix
      ./bootloader.nix
      ./nix-settings.nix
      ./nixpkgs.nix
      ./gc.nix
      # ./auto-upgrade.nix
      ./linux-kernel.nix
      ./screen.nix
      # ./location.nix
      ./display-manager.nix
      ./theme.nix
      ./internationalisation.nix
      ./fonts.nix
      ./security-services.nix
      ./services.nix
      # ./printing.nix
      ./hyprland.nix
      ./networking.nix
      # ./open-ssh.nix
      ./mosh.nix
      ./firewall.nix
      ./users.nix
      ./virtualisation.nix
      ./programming-languages.nix
      ./lsp.nix
      ./info-fetchers.nix
      ./dev-tools.nix
      ./terminal.nix
      ./llm.nix
      ./work.nix
    ];

    vmwareExtras = [
      ./opengl-vm.nix
      ./vmware-guest.nix
      { networking.hostName = lib.mkForce "isitreal-vm"; }
      ./vm-autologin.nix
    ];

    proxmoxExtras = [
      ./opengl-vm.nix
      ./proxmox.nix
      { networking.hostName = lib.mkForce "gsh-work-vm"; }
      ./vm-autologin.nix
    ];
  in
  {
    nixosConfigurations.isitreal-laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = commonModules ++ [
        ./nvidia.nix
        ./opengl.nix
        ./bluetooth.nix
        ./power.nix
      ];
    };

    nixosConfigurations.vmware-vm = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = commonModules ++ vmwareExtras ++ [
        {
          boot.initrd.availableKernelModules = lib.mkForce [ ];
          boot.initrd.kernelModules = lib.mkForce [ ];
        }
      ];
    };

    packages.x86_64-linux.vmware-image = inputs.nixos-generators.nixosGenerate {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      format = "vmware";
      modules = (lib.filter (m: m != ./hardware-configuration.nix && m != ./bootloader.nix) commonModules) ++ vmwareExtras ++ [
        { virtualisation.diskSize = 40 * 1024; }
      ];
    };

    nixosConfigurations.proxmox-vm = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = commonModules ++ proxmoxExtras;
    };

    packages.x86_64-linux.proxmox-image = inputs.nixos-generators.nixosGenerate {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      format = "qcow";
      modules = (lib.filter (m: m != ./hardware-configuration.nix && m != ./bootloader.nix) commonModules) ++ proxmoxExtras ++ [
        { virtualisation.diskSize = 100 * 1024; }
      ];
    };
  };
}
