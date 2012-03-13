PROMPT='%B>%(0?.. %{$fg[red]%}%?) %{$fg[blue]%}%~$(check_git_prompt_info) %{$fg[white]%}%(!.#.$) %b%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[white]%}] %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[white]%}]"

function check_git_prompt_info() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        if [[ -z $(git_prompt_info) ]]; then
            echo " %{$fg[magenta]%}detached-head%{$reset_color%})"
        else
            echo " %{$fg[white]%}[%{$fg[red]%}$(git_prompt_short_sha) %{$fg[white]%}@ $(git_prompt_info)"
        fi
    fi
}

# vim:filetype=zsh expandtab shiftwidth=4
