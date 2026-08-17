{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (python312.withPackages(ps: with ps; [ pygobject3 gobject-introspection pyqt6-sip]))
    uv
    python312Packages.hatchling

    go
    gotools
    golangci-lint
    delve
  ];
}
