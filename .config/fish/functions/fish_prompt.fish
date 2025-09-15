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
        prompt_segment magenta bryellow " (py:$venvname) "
        return
    end
    if set -q CONDA_DEFAULT_ENV
        prompt_segment magenta bryellow " (conda:$CONDA_DEFAULT_ENV) "
        return
    end
    if test -f package.json; and set -q npm_config_prefix
        set -l node_version (node --version 2>/dev/null | string replace 'v' '')
        if test -n "$node_version"
            prompt_segment green brwhite " (node:$node_version) "
        end
    end
end

function show_user -d "Show user and hostname with terminal color styling"
    if not contains $__cached_username $default_user; or test -n "$SSH_CLIENT"
        prompt_segment normal brgreen " $__cached_username"
        if test "$__cached_username" != "$__cached_hostname"
            prompt_segment normal brwhite "@"
            prompt_segment normal brcyan "$__cached_hostname "
            set -g pad ""
        else
            prompt_segment normal brwhite " "
        end
    end
end

function _set_venv_project --on-variable VIRTUAL_ENV -d "Handle virtual environment projects"
    if test -n "$VIRTUAL_ENV" -a -e "$VIRTUAL_ENV/.project"
        set -g VIRTUAL_ENV_PROJECT (cat "$VIRTUAL_ENV/.project")
    else
        set -e VIRTUAL_ENV_PROJECT
    end
end

function show_pwd -d "Show current directory with smart truncation"
    set -l current_dir (pwd)
    set -l display_path (pwd)
    set display_path (string replace -r "^$HOME" "~/" "$display_path")
    set display_path (string replace -r "/Documents?" "⬢" "$display_path")
    set display_path (string replace -r "/Downloads?" "⬇" "$display_path")
    set display_path (string replace -r "/Desktop" "⌨" "$display_path")
    prompt_segment normal brcyan "$display_path "
end

function show_git -d "Show git status with terminal color styling and performance optimization"
    if not git rev-parse --git-dir >/dev/null 2>&1
        return
    end
    set -l branch_symbol "⎇"
    set -l ahead_symbol "↑"
    set -l behind_symbol "↓"
    set -l modified_symbol "±"
    set -l untracked_symbol "?"
    set -l staged_symbol "●"
    set -l branch_name (git symbolic-ref --short HEAD 2>/dev/null; or git rev-parse --short HEAD 2>/dev/null)
    if test -z "$branch_name"
        return
    end
    set -l git_status_output (git status --porcelain=v1 --branch --ahead-behind 2>/dev/null)
    if test $status -ne 0
        return
    end
    set -l is_dirty (echo "$git_status_output" | grep -v '^##' | wc -l | string trim)
    set -l ahead_behind (echo "$git_status_output" | head -1 | string match -r '\[ahead (\d+).*behind (\d+)\]|\[ahead (\d+)\]|\[behind (\d+)\]')
    if test "$is_dirty" != "0"
        prompt_segment normal yellow "$branch_symbol $branch_name$modified_symbol "
    else
        prompt_segment normal green "$branch_symbol $branch_name "
    end
end

function show_prompt -d "Show prompt character with terminal color privilege styling"
    if test $__cached_uid -eq 0
        prompt_segment red brwhite " [ROOT] # "
        set_color normal
        echo -n " "
    else
        prompt_segment normal bryellow "⬢ "
    end
    set_color normal
end

function fish_prompt -d "Main prompt with terminal colors and high performance"
    set -g RETVAL $status
    set -g pad " "
    show_virtualenv
    show_user
    show_pwd
    show_git
    show_prompt
end

if not set -q __cached_hostname
    set -g __cached_hostname (hostname -s)
end
if not set -q __cached_username
    set -g __cached_username (whoami)
end
if not set -q __cached_uid
    set -g __cached_uid (id -u)
end

if not set -q default_user
    set -g default_user $USER
end
