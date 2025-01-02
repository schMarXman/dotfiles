{ config, pkgs, lib, ... }: 

{
    options = {
        ghostty.enable = lib.mkEnableOption "Enables Ghostty terminal and config";
    };

    config = lib.mkIf config.ghostty.enable {
        home = {
            packages = with pkgs; [
                ghostty
            ];

            file = {
                ".config/ghostty/config".source = ../../ghostty/config;
            };
        };
    };
}
