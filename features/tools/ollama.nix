{ lib, config, pkgs, ... }:
let
  cfg = config.my.features.ollama;
  inherit (lib) mkEnableOption mkIf; 
in
{
  options.my.features.ollama.enable = mkEnableOption "Ollama with local NVIDIA offload";

  config = mkIf cfg.enable {
    # environment.systemPackages = [ pkgs.unstable.alpaca ];

    # Use the official `services.ollama` module instead of creating a custom unit.
    services.ollama = {
      enable = true;
      package = pkgs.ollama-cuda;
      environmentVariables = {
        OLLAMA_HOST = "0.0.0.0:11434";
        OLLAMA_NUM_PARALLEL = "1";
        OLLAMA_MAX_LOADED_MODELS = "1";
        OLLAMA_KEEP_ALIVE = "5m";
      };
      # Other options (user, group, port, models, openFirewall, etc.) can be
      # set by the user in their host/profile config if desired.
    };
  };
}