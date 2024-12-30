{ config, pkgs, lib, inputs, ... }: 

{
    options = {
        ghostty.enable = lib.mkEnableOption "Enables Ghostty terminal and settings";
    };

    config = lib.mkIf config.ghostty.enable {
        home = {
            packages = with pkgs; [
                inputs.ghostty.packages.${system}.default
            ];

            file = {
                ".config/ghostty/config".source = ../../ghostty/config;
            };
        };

        nix = {
            package = pkgs.nix;
            settings = {
                extra-substituters = [
                    "https://ghostty.cachix.org"
                ];
                extra-trusted-public-keys = [
                    "ghostty.cachix.org-1:qb389yta6gtyneehvqg58y0wnhjqoqgna+wbnpwwxns="
                ];
            };
        };
    };
}
