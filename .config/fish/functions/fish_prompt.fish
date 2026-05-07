set -g pad " "
set -g default_user $USER

set -g __cached_hostname (hostname -s)
set -g __cached_username (whoami)
set -g __cached_uid (id -u)

function prompt_segment -d "Prompt segment using terminal color variables"
    set -l bg $argv[1]
    set -l fg $argv[2]
    if test (count $argv) -lt 2
        return 1
    end
    set_color -b $bg 2>/dev/null
    set_color $fg 2>/dev/null
    if test -n "$argv[3]"
        echo -n -s $argv[3]
    end
end

function show_virtualenv -d "Show Python/Conda virtual environments"
    if set -q VIRTUAL_ENV
        set -l venvname (basename "$VIRTUAL_ENV")
        prompt_segment normal bryellow "(py:$venvname) "
        return
    end
    if set -q CONDA_DEFAULT_ENV
        prompt_segment normal bryellow "(conda:$CONDA_DEFAULT_ENV) "
        return
    end
end

function show_user -d "Show user and hostname only when relevant"
    if not contains $__cached_username $default_user; or test -n "$SSH_CLIENT"
        prompt_segment normal brgreen "$__cached_username"
        prompt_segment normal brwhite "@"
        prompt_segment normal brcyan "$__cached_hostname "
    end
end

function show_pwd -d "Show current directory in blue"
    set -l display_path (pwd)
    set display_path (string replace -r "^$HOME" "~" "$display_path")
    prompt_segment normal blue "$display_path "
end

function show_git -d "Show git branch and modified file count"
    if not git rev-parse --git-dir >/dev/null 2>&1
        return
    end

    set -l branch_symbol "⎇"
    set -l branch_name (git symbolic-ref --short HEAD 2>/dev/null; or git rev-parse --short HEAD 2>/dev/null)
    if test -z "$branch_name"
        return
    end

    prompt_segment normal green "$branch_symbol $branch_name "

    set -l porcelain (git status --porcelain 2>/dev/null)
    if test -n "$porcelain"
        set -l modified (echo "$porcelain" | grep -c '^.M\|^.D')
        set -l staged (echo "$porcelain" | grep -c '^[MADRC]')
        set -l untracked (echo "$porcelain" | grep -c '^??')

        if test $modified -gt 0
            prompt_segment normal yellow "$modified modified "
        end
        if test $staged -gt 0
            prompt_segment normal brgreen "$staged staged "
        end
        if test $untracked -gt 0
            prompt_segment normal brred "$untracked untracked "
        end
    end

    set -l upstream (git rev-parse --abbrev-ref '@{upstream}' 2>/dev/null)
    if test -n "$upstream"
        set -l ahead (git rev-list --count '@{upstream}..HEAD' 2>/dev/null)
        set -l behind (git rev-list --count 'HEAD..@{upstream}' 2>/dev/null)
        if test "$ahead" -gt 0 2>/dev/null
            prompt_segment normal cyan "↑$ahead "
        end
        if test "$behind" -gt 0 2>/dev/null
            prompt_segment normal magenta "↓$behind "
        end
    end
end

function show_status -d "Show last command exit status if non-zero"
    if test $RETVAL -ne 0
        prompt_segment normal brred "✘ $RETVAL "
    end
end

function show_prompt -d "Show the circle prompt character"
    if test $__cached_uid -eq 0
        prompt_segment normal brred "# "
    else
        set_color normal
        echo -n "⏺ "
    end
    set_color normal
end

function fish_prompt -d "Main prompt"
    set -g RETVAL $status
    show_status
    show_virtualenv
    show_user
    show_pwd
    show_git
    show_prompt
end