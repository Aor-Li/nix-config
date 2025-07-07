{ ... }:
{
  programs.tmux = {
    enable = true;
    mouse = true;
    terminal = "xterm-256color";
    extraConfig = ''
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"

      unbind r
      bind r source-file ~/.config/tmux/.tmux.conf
    '';
  };
}
