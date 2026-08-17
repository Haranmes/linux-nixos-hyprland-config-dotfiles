{ pkgs, ... }:

{
  # Enable Docker
  # virtualisation.docker = {
  #   enable = true;
  #   rootless = {
  #     enable = true;
  #     setSocketVariable = true;
  #     daemon.settings.features.cdi = true;
  #   };
  # };
  # users.extraGroups.docker.members = [ "xnm" ];

  virtualisation.docker.enable = false;

  # Enable Podman
  virtualisation.podman = {
    enable = true;

    # Create a `docker` alias for podman, to use it as a drop-in replacement
    dockerCompat = false;
    dockerSocket.enable = false;

    # Required for containers under podman-compose to be able to talk to each other.
    defaultNetwork.settings.dns_enabled = true;
  };
  environment.variables.DBX_CONTAINER_MANAGER = "podman";
  users.extraGroups.podman.members = [ "xnm" ];

  # Single-node k3s cluster for local Kubernetes dev, replacing the
  # docker-compose-centric workflow. Podman/docker-compose stay available
  # below for cases where a full cluster is overkill.
  services.k3s = {
    enable = true;
    role = "server";
    extraFlags = "--write-kubeconfig-mode=644";
  };

  environment.systemPackages = with pkgs; [
    nerdctl

    distrobox
    qemu
    lima
    lima-additional-guestagents

    podman-compose
    podman-tui

    docker-client
    docker-compose
    lazydocker
    docker-credential-helpers

    kubectl
    kubernetes-helm
    k9s
    kubectx
  ];
}
