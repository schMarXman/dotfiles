{ config, pkgs, lib, ... }: 

{
    options = {
        brave.enable = lib.mkEnableOption "Enables Brave Browser settings and extensions";
    };

    config = lib.mkIf config.brave.enable {
        programs.chromium = {
            enable = true;
            package = pkgs.brave;
            extensions = [
                # Vimium C
                { id = "hfjbmagddngcpeloejdejnfgbamkjaeg"; }
                # KeepassXC
                { id = "oboonakemofpalcgghocfoadofidjkkk"; }
            ];
        };
    };
}
