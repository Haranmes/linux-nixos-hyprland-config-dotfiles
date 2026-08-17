{ pkgs, ... }:

{
  programs.direnv.enable = true;

  environment.systemPackages = with pkgs; [
    gcc

    devenv
    sops
    rops
    git
    git-lfs
    lefthook
    pre-commit-hook-ensure-sops
    lazygit
    lazynpm
    diffnav
    license-generator
    git-ignore
    gitleaks
    pass-git-helper
    jujutsu
    jjui
    just
    mise
    gh
    gh-dash
    hurl
    grex
  ];
}
