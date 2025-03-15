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
            gnomeExtensions.top-panel-notification-icons-revived
            gnomeExtensions.transparent-top-bar-adjustable-transparency
            gnomeExtensions.media-controls
            gnomeExtensions.pano
        ];

        # Forge extension config
        # home.file = {
        #     ".config/forge/config/windows.json".source = ../../forge/config/windows.json;
        # };

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

            "org/gnome/desktop/privacy" = {
                remove-old-temp-files = true;
                remove-old-trash-files = true;
                old-files-age = 30;
            };

            # Keybindings
            "org/gnome/desktop/wm/keybindings" = {
                minimize = ["<Super>x"];
                switch-to-workspace-left = ["<Alt><Super>j"];
                switch-to-workspace-right = ["<Alt><Super>k"];
            };

            # Lock PC
            "org/gnome/settings-daemon/plugins/media-keys" = {
                screensaver = ["<Super>q"];
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
                command = "ghostty";
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
                    "notification-icons@muhammad_ans.github"
                    "transparent-top-bar@ftpix.com"
                    "mediacontrols@cliffniff.github.com"
                    "gsconnect@andyholmes.github.io"
                    "pano@elhan.io"
                ];
                # Dock pinned apps
                favorite-apps = [
                    "org.gnome.Nautilus.desktop"
                    "librewolf.desktop"
                    "com.mitchellh.ghostty.desktop" 
                ];
            };
            "org/gnome/shell/extensions/notification-icons" = {
                right-side = true;
            };
            "org/gnome/shell/extensions/dash-to-dock" = {
                apply-custom-theme = false;
                transparency-mode = "DYNAMIC";
                running-indicator-style = "DOT";
            };
            # Transparent top bar extension settings
            "com/ftpix/transparentbar" = {
                transparency = 50;
            };
            # Media controlls extension settings
            "org/gnome/shell/extensions/mediacontrols" = {
                extension-position = "Right";
                hide-media-notification = false;
                show-control-icons = false;
                labels-order = ["ARTIST" "-" "TITLE"];
                mouse-action-left = "PLAY_PAUSE";
                mouse-action-right = "SHOW_POPUP_MENU";
                mouse-action-double = "RAISE_PLAYER";
            };
            "org/gnome/shell/extensions/pano" = {
                play-audio-on-copy = false;
                send-notification-on-copy = false;
            };
        };
    };
}
