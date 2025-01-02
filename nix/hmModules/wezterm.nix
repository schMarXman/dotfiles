{ config, lib, ... }: 

{
    options = {
        wezterm.enable = lib.mkEnableOption "Enables Wezterm terminal and config";
    };

    config = lib.mkIf config.wezterm.enable {
        programs.wezterm.enable = true;
        programs.wezterm.extraConfig = builtins.readFile ../../wezterm/wezterm.lua;
    };
}
