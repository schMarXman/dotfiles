{ config, pkgs, lib, ... }: 

{
    options = {
        gnome.enable = lib.mkEnableOption "Enables gnome system settings";
    };

    config = lib.mkIf config.gnome.enable {
        services.displayManager.gdm.enable = true;
        services.desktopManager.gnome.enable = true;

        environment.gnome.excludePackages = with pkgs; [
            epiphany
            gnome-music
        ];

        # GSConnect extension with open ports etc.
        programs.kdeconnect = {
            enable = true;
            package = pkgs.gnomeExtensions.gsconnect;
        };
    };
}
