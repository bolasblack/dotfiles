#!/usr/bin/env sh

choice="$(
  sesh list --icons -t | fzf --tmux 80%,70% \
    --no-sort --ansi --border-label ' sesh ' --prompt '🪟  ' \
    --header '^a all ^f find' \
    --bind 'tab:down,btab:up' \
    --bind 'ctrl-a:change-prompt(🪟  )+reload(sesh list --icons -t)' \
    --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
    --preview-window 'right:55%' \
    --preview 'sesh preview {}' \
    -- --ansi
)"


if [ -n "$choice" ]; then
  sesh connect "$choice"
fi
