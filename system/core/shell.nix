{ pkgs, ... }:
{
  # Enable Zsh globally and set as default shell for new users
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
}
