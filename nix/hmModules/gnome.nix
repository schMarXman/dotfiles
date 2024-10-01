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

        # Gnome settings
        dconf.settings = {
        # Window buttons
        "org/gnome/desktop/wm/preferences" = {
            button-layout = "appmenu:minimize,close";
        };

        # Keybindings
        "org/gnome/desktop/wm/keybindings" = {
            minimize = ["<Super>x"];
        };

        "org/gnome/shell" = {
            disable-user-extensions = false;
            enabled-extensions = [
                "appindicatorsupport@rgcjonas.gmail.com"
                "dash-to-dock@micxgx.gmail.com"
                "forge@jmmaranan.com"
                "tailscale-status@maxgallup.github.com"
                ];
            };
        };
    };
}
