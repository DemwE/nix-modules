{ lib, config, pkgs, ... }:
let
  inherit (lib) mkOption types;
  cfg = config.my.theme;
  # Minimal palette map (extend if you add more flavors)
  palettes = {
    mocha = {
      base = "#1e1e2e"; mantle = "#181825"; crust = "#11111b";
      surface0 = "#313244"; surface1 = "#45475a"; surface2 = "#585b70";
      overlay0 = "#6c7086"; overlay1 = "#7f849c"; overlay2 = "#9399b2";
      subtext0 = "#a6adc8"; subtext1 = "#bac2de"; text = "#cdd6f4";
      lavender = "#b4befe"; blue = "#89b4fa"; sapphire = "#74c7ec"; sky = "#89dceb";
      teal = "#94e2d5"; green = "#a6e3a1"; yellow = "#f9e2af"; peach = "#fab387";
      maroon = "#eba0ac"; red = "#f38ba8"; mauve = "#cba6f7"; pink = "#f5c2e7";
      flamingo = "#f2cdcd"; rosewater = "#f5e0dc";
    };
  };
  palette = palettes.${cfg.flavor} or palettes.mocha;
in {
  options.my.theme = {
    flavor = mkOption { type = types.str; default = "mocha"; description = "Catppuccin flavor name"; };
    accent = mkOption { type = types.str; default = "lavender"; description = "Accent color label used to build theme variants"; };
    font.family = mkOption { type = types.str; default = "Noto Sans"; description = "Primary UI font family"; };
    font.sizeSDDM = mkOption { type = types.str; default = "9"; description = "Font size for SDDM theme override"; };
    packageName = mkOption { type = types.str; readOnly = true; description = "Derived Catppuccin package base name"; };
    sddmTheme = mkOption { type = types.str; readOnly = true; description = "Derived SDDM theme name"; };
    gtkTheme = mkOption { type = types.str; readOnly = true; description = "Derived GTK theme package variant"; };
    palette = mkOption { type = types.attrsOf types.str; readOnly = true; description = "Resolved color palette mapping"; };
  };
  config = {
    my.theme.packageName = "catppuccin-${cfg.flavor}";
    my.theme.sddmTheme = "catppuccin-${cfg.flavor}";
    my.theme.gtkTheme = "catppuccin-${cfg.flavor}-${cfg.accent}-standard";
    my.theme.palette = palette;
  };
}
