 {
  flake.nixosModules.ml = { config, lib, pkgs, ...}:
{
    environment.systemPackages = with pkgs; [
      # --- AI Agent Frameworks ---
      autogen # Framework for building autonomous AI agents

      # --- Data Versioning ---
      dvc # Git for data, models, and pipelines

      # --- Language Models ---
      llama-cpp
      # Run large language models locally
      ollama
      lmstudio
      # --- Model Tools ---
      # --- NLP Frameworks ---

      # --- Speech Recognition ---
      whisper-cpp # Avoid include/ collisions in HM buildEnv
      # Open source speech recognition toolkit
      openclaw
      # Open source code generation toolkit
      opencode
      opencode-desktop # Desktop app for opencode
      # --- Vector Databases ---
      qdrant # Vector database management for semantic search
      ggml # General-purpose machine learning library

    ];
 };
 }
