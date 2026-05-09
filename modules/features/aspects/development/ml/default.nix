 {
  flake.nixosModules.ml = {  config,
  lib,
  pkgs,
  ...}:
with lib;
let
  pkgIf = name: lib.optionals (builtins.hasAttr name pkgs) [ pkgs.${name} ];
  binOnly =
    pkg:
    pkgs.buildEnv {
      name = "${lib.getName pkg}-bin";
      pathsToLink = [ "/bin" ];
      paths = [ pkg ];
    };
in
{
    environment.systemPackages = [
      # --- AI Agent Frameworks ---
      pkgs.autogen # Framework for building autonomous AI agents

      # --- Data Versioning ---
      pkgs.dvc # Git for data, models, and pipelines

      # --- Language Models ---
      (binOnly pkgs.llama-cpp) # Avoid include/ collisions in  buildEnv
      # Run large language models locally
      pkgs.ollama
   #   pkgs.lmstudio
      # --- Model Tools ---
      # --- NLP Frameworks ---

      # --- Speech Recognition ---
      (binOnly pkgs.whisper-cpp) # Avoid include/ collisions in HM buildEnv
    #  pkgs.openclaw # Open source speech recognition toolkit
      pkgs.opencode # Open source code generation toolkit
      pkgs.opencode-desktop # Desktop app for opencode
      # --- Vector Databases ---
      pkgs.qdrant # Vector database management for semantic search
    ]
    # Optional packages (may live in overlays or be removed/renamed in nixpkgs)
    ++ pkgIf "text-generation-webui"
    ++ pkgIf "ggml-tools"
    ++ pkgIf "huggingface-cli"
    ++ pkgIf "haystack"
    ++ pkgIf "comfyui"
    ++ pkgIf "milvus";
 };
 }
