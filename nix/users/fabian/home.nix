{ pkgs, ... }:

{
  gnome.enable = true;
  ghostty.enable = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "fabian";
  home.homeDirectory = "/home/fabian";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    telegram-desktop
    keepassxc
    lazygit
    cmake
    fzf
    mpv
    brave
    btop

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".config/nvim/init.lua".source = ../../../nvim/init.lua;
    ".config/nvim/lazy-lock.json".source = ../../../nvim/lazy-lock.json;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/fabian/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    SUDO_EDITOR = "nvim";
  };

  home.shellAliases = {
    hm = "home-manager --flake ~/Projects/dotfiles/nix";
    nos = "sudo nixos-rebuild --flake ~/Projects/dotfiles/nix";
    lg = "lazygit";
    v = "nvim";
    sudo = "sudo ";
    gc = "home-manager expire-generations \"-14 days\" && sudo nix-collect-garbage --delete-older-than 14d";
    nos-update = "nix flake update --flake ~/Projects/dotfiles/nix/";
  };

  programs = {
    librewolf.enable = true;
    neovim.enable = true;
    bash.enable = true;
    git = {
      enable = true;
      userEmail = "asdf@test.com";
      userName = "schMarXman";

    };
    zoxide = {
      enable = true;
      options = [ "--cmd cd" ];
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
