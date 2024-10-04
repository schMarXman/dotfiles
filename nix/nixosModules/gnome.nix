{ config, pkgs, lib, ... }: 

{
    options = {
        gnomeExcludePkgs.enable = lib.mkEnableOption "Enables gnome system settings";
    };

    config = lib.mkIf config.gnomeExcludePkgs.enable {
        environment.gnome.excludePackages = with pkgs; [
            epiphany
            gnome-music
        ];
    };
}
