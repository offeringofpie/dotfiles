function fish_right_prompt -d "Fast right prompt with git status"
    set -l cmd_duration $CMD_DURATION
    
    if test $cmd_duration -gt 2000
        set_color ff6600  # Cyberpunk orange
        printf "%ds " (math "$cmd_duration / 1000")
        set_color normal
    end
    
    if git rev-parse --git-dir >/dev/null 2>&1
        set -l dirty_count (git status --porcelain=v1 --untracked-files=no --ignore-submodules=dirty 2>/dev/null | wc -l | string trim)
        
        if test "$dirty_count" != "0"
            set_color ffff00  # Cyberpunk yellow
            printf " ≍ %s" $dirty_count
            set_color normal
        else
            # Show clean status with subtle indicator
            set_color 00ff41  # Cyberpunk green
            printf " ✓"
            set_color normal
        end
    end
end
