{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    python312Packages.python-lsp-server
    ty
    ruff
    vscode-langservers-extracted
    yaml-language-server
    taplo #toml formatter & lsp
    tombi
    bash-language-server
    graphql-language-service-cli
    dockerfile-language-server
    just-lsp
    docker-compose-language-service
    terraform-ls
    hyprls
    gopls
  ];
}
