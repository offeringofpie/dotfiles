set -g async_prompt_functions get_git_status_for_async

function __is_git_repo -d "Quick git repository check"
    git rev-parse --git-dir >/dev/null 2>&1
end

function get_git_status_for_async -d "Async git status function"
    if not __is_git_repo
        return
    end
    
    set -l status_count (git status --porcelain=v1 --untracked-files=no --ignore-submodules=dirty 2>/dev/null | wc -l | string trim)
    
    if test "$status_count" != "0"
        printf "± %s" $status_count
    end
end

function get_git_status_for_async_loading_indicator -d "Loading indicator for git status"
    if __is_git_repo
        set_color brblack
        echo -n " …"
        set_color normal
    end
end

function fish_right_prompt -d "Async right prompt"
    set -l cmd_duration $CMD_DURATION
    
    if test $cmd_duration -gt 2000
        set_color yellow
        printf "%ds " (math "$cmd_duration / 1000")
        set_color normal
    end
    
    set_color yellow
    echo -n (get_git_status_for_async)
    set_color normal
end
