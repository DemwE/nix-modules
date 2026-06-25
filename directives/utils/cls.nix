pkgs: {
  cls = pkgs.writeShellApplication {
    name = "cls";
    text = ''
      clear
    '';
  };
}
