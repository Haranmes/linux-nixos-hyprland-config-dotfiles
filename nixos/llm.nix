{ pkgs, config, ... }:

{

  services.ollama = {
    enable = true;
    loadModels = [ "gemma4:e2b" "gemma4:e4b" "gpt-oss:20b" "jaahas/qwen3.5-uncensored:4b" "jaahas/qwen3.5-uncensored:9b" "devstral-small-2:24b" "glm-4.7-flash" "nomic-embed-text-v2-moe" "x/z-image-turbo" "x/flux2-klein:4b" "x/flux2-klein:9b" ];
    package = pkgs.ollama-cuda;
  };


  services.open-webui = {
    enable = false;
    port = 8888;
    host = "127.0.0.1";
  };
  
  environment.systemPackages = with pkgs; [
    nix-ai-tools.backlog-md

    oterm
    # alpaca

    claude-code

    # aider-chat
    # nix-ai-tools.pi
    # nix-ai-tools.ccusage-pi
    # nix-ai-tools.codex

    # tgpt
    # smartcat
    # nextjs-ollama-llm-ui
    # open-webui

    chromium
    # playwright
  ];
}
