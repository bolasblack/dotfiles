#!/usr/bin/env sh

choice="$(
    {
      tmux list-sessions -F "#{session_id}	#{session_name}	#{session_windows}	#{?session_attached,attached,}" |
      while IFS="$(printf "\t")" read -r session_id session_name session_windows session_attached; do
        if [ -n "$session_attached" ]; then
          printf "\t\t- %s: %s windows (%s)\n" "$session_name" "$session_windows" "$session_attached"
        else
          printf "\t\t- %s: %s windows\n" "$session_name" "$session_windows"
        fi

        tmux list-windows -t "$session_id" -F "#{window_id}	#{pane_id}	├─> #{?window_active,+,-} #{session_name}: #{window_name} #{window_flags} [#{pane_current_command}] \"#{pane_current_path}\""
      done
    } |
      fzf --tmux 80%,70% \
        --no-sort --ansi \
        --prompt="⚡  " \
        --delimiter="	" \
        --with-nth=3.. \
        --preview="tmux capture-pane -ep -t {2} -S -200" \
        --preview-window="right,60%,wrap"
)"

window=""
if [ -n "$choice" ]; then
    window="$(printf "%s" "$choice" | cut -f1)"
fi

if [ -n "$window" ]; then
    tmux switch-client -t "$window"
fi
