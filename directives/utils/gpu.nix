# GPU utilities
# pkgs: { nvidia-offload }

pkgs: {

  # Smart nvidia-offload wrapper:
  # - In Hybrid mode: runs app with NVIDIA PRIME offload env vars
  # - In Integrated mode: passthrough (no NVIDIA available)
  nvidia-offload = pkgs.writeShellApplication {
    name = "nvidia-offload";
    runtimeInputs = [ pkgs.supergfxctl ];
    text = ''
      MODE=$(supergfxctl --get 2>/dev/null || echo "Hybrid")
      if [ "$MODE" = "Integrated" ]; then
        exec "$@"
      else
        __NV_PRIME_RENDER_OFFLOAD=1 \
        __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0 \
        __GLX_VENDOR_LIBRARY_NAME=nvidia \
        __VK_LAYER_NV_optimus=NVIDIA_only \
        exec "$@"
      fi
    '';
  };

}
