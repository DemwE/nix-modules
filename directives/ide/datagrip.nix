# DataGrip package definition
# pkgs: { datagrip }
# Uses ~/.toolchains/nodejs/bin so plugins (e.g. GitHub Copilot) can find Node.js.

pkgs: {
	datagrip = pkgs.jetbrains.datagrip.overrideAttrs (oldAttrs: {
		nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [ pkgs.makeWrapper ];
		postInstall = (oldAttrs.postInstall or "") + ''
			wrapProgram $out/bin/datagrip \
				--run 'export PATH="$HOME/.toolchains/nodejs/bin:$PATH"'
		'';
	});
}
