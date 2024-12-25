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
            gnomeExtensions.caffeine
        ];

        # Gnome settings
        dconf.settings = {
            # Window buttons
            "org/gnome/desktop/wm/preferences" = {
                button-layout = "appmenu:minimize,close";
            };
            "org/gnome/mutter" = {
                dynamic-workspaces = true;
            };
            "org/gnome/desktop/interface" = {
                enable-hot-corners = false;
            };

            # Keybindings
            "org/gnome/desktop/wm/keybindings" = {
                minimize = ["<Super>x"];
                switch-to-workspace-left = ["<Alt><Super>h"];
                switch-to-workspace-right = ["<Alt><Super>l"];
            };
            "org/gnome/desktop/wm/keybindings/" = {
            };
            # Define new custom keybindings
            "org/gnome/settings-daemon/plugins/media-keys" = {
                custom-keybindings = [
                    "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
                    "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
                ];
            };
            # Set custom keybinding values
            "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
                name = "Nautilus";
                command = "nautilus";
                binding = "<Super>e";
            };
            "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
                name = "Terminal";
                command = "kgx";
                binding = "<Super>t";
            };

            "org/gnome/shell" = {
                disable-user-extensions = false;
                enabled-extensions = [
                    "appindicatorsupport@rgcjonas.gmail.com"
                    "dash-to-dock@micxgx.gmail.com"
                    "forge@jmmaranan.com"
                    "tailscale-status@maxgallup.github.com"
                    "caffeine@patapon.info"
                ];
            };
        };
    };
}
