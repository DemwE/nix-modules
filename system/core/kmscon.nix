{ ... }:

{
  services.kmscon = {
  enable = true;
  extraOptions = "--term xterm-256color";
  fonts = [
    {
      name = "JetBrainsMono Nerd Font";
      package = pkgs.nerd-fonts.jetbrains-mono;
    }
  ];
};
}