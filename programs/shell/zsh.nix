# My shell configuration
{ pkgs, lib, config, ... }:
# let fetch = config.var.theme.fetch; # neofetch, nerdfetch, pfetch
# in {
{
  home.packages = with pkgs; [ bat ripgrep tldr sesh ];

  home.sessionPath = [ "$HOME/go/bin" ];

  programs.zsh = {
    initExtraFirst = ''
      __conda_setup="$('/home/jonwick/conda/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
          if [ $? -eq 0 ]; then
              eval "$__conda_setup"
          else
              if [ -f "/home/jonwick/conda/etc/profile.d/conda.sh" ]; then
                  . "/home/jonwick/conda/etc/profile.d/conda.sh"
              else
                  export PATH="/home/jonwick/conda/bin:$PATH"
              fi
          fi
          unset __conda_setup
          # <<< conda initialize <<<
    '';

    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;

    # initExtraFirst = ''
    #   # bindkey -e
    #   # ${if fetch == "neofetch" then
    #   #   pkgs.neofetch + "/bin/neofetch"
    #   # else if fetch == "nerdfetch" then
    #   #   "nerdfetch"
    #   # else if fetch == "pfetch" then
    #   #   "echo; ${pkgs.pfetch}/bin/pfetch"
    #   # else
    #   #   ""}
    #
    #   function sesh-sessions() {
    #     session=$(sesh list -t -c | fzf --height 70% --reverse)
    #     [[ -z "$session" ]] && return
    #     sesh connect $session
    #   }
    #
    #   zle     -N             sesh-sessions
    #   bindkey -M emacs '\es' sesh-sessions
    #   bindkey -M vicmd '\es' sesh-sessions
    #   bindkey -M viins '\es' sesh-sessions
    # '';

    history = {
      ignoreDups = true;
      save = 10000;
      size = 10000;
    };

    profileExtra = lib.optionalString (config.home.sessionPath != [ ]) ''
      export PATH="$PATH''${PATH:+:}${
        lib.concatStringsSep ":" config.home.sessionPath
      }"
    '';

    shellAliases = {
      hm = "nvim ~/.config/home-manager/";
      bioinfo = "ssh wickj2@140.160.231.67 -p 59";
      clipLast = ''wl-copy "!!" '';
      clip = "wl-copy";
      sd = "cd ~ && cd $(find * -type d | fzf)";
      vim = "nvim";
      vi = "nvim";
      v = "nvim .";
      c = "clear";
      clera = "clear";
      celar = "clear";
      e = "exit";
      cd = "z";
      ls = "eza --icons=always --no-quotes";
      tree = "eza --icons=always --tree --no-quotes";
      sl = "ls";
      open = "${pkgs.xdg-utils}/bin/xdg-open";
      icat = "${pkgs.kitty}/bin/kitty +kitten icat";
      ssh = "kitty +kitten ssh";

      wireguard-import = "nmcli connection import type wireguard file";

      notes =
        "nvim ~/nextcloud/Notes/index.md --cmd 'cd ~/nextcloud/Notes' -c ':Telescope find_files'";
      note = "notes";

      # git
      g = "lazygit";
      ga = "git add";
      gc = "git commit";
      gcu = "git add . && git commit -m 'Update'";
      gp = "git push";
      gpl = "git pull";
      gs = "git status";
      gd = "git diff";
      gco = "git checkout";
      gcb = "git checkout -b";
      gbr = "git branch";
      grs = "git reset HEAD~1";
      grh = "git reset --hard HEAD~1";

      gaa = "git add .";
      gcm = "git commit -m";
    };
  };

}
