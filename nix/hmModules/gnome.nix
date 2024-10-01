{ config, pkgs, lib, ... }: 

{
    options = {
        gnome.enable = lib.mkEnableOption "Enables gnome settings and extensions";
    };

    config = lib.mkIf config.gnome.enable {
        home.packages = with pkgs; [
            # Gnome extensions
            gnomeExtensions.appindicator
            gnomeExtensions.dash-to-dock
            gnomeExtensions.forge
            gnomeExtensions.tailscale-status
        ];
    };
}
