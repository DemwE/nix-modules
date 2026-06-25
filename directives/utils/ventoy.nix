# Packages with cleared knownVulnerabilities
# Use: pkgs.custom.ventoy

pkgs: {
  ventoy = pkgs.ventoy-full-gtk.overrideAttrs (old: {
    meta = old.meta // {
      knownVulnerabilities = [ ];
    };
  });
}
