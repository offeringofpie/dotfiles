function git_branch_name -d "Get the name of the current Git branch, tag or sha1"
  set -l branch_name (command git symbolic-ref --short HEAD 2>/dev/null)

  if test -z "$branch_name"
    set -l tag_name (command git describe --tags --exact-match HEAD 2>/dev/null)

    if test -z "$tag_name"
      command git rev-parse --short HEAD 2>/dev/null
    else
      printf "%s\n" "$tag_name"
    end
  else
    printf "%s\n" "$branch_name"
  end
end


function git_untracked_files -d "Get the number of untracked files in a repository"
    git_is_repo; and command git ls-files --others --exclude-standard | command awk '

    BEGIN {
        n = 0
    }

    { n++ }

    END {
        print n
        exit !n
    }
  '
end

function git_is_touched -d "Test if there are any changes in the working tree"
  git_is_staged; or git_is_dirty
end


function git_is_tag -d "Test if HEAD is on top of a tag (can be simple, annotated or signed)"
  git_is_detached_head; and command git describe --tags --exact-match HEAD 2>/dev/null > /dev/null
end


function git_is_stashed -d "Test if there are changes in the Git stash"
  command git rev-parse --verify --quiet refs/stash > /dev/null 2>/dev/null
end

function git_is_staged -d "Test if there are changes staged for commit"
  git_is_repo; and not command git diff --cached --no-ext-diff --quiet --exit-code 2>/dev/null
end

function git_is_repo -d "Test if the current directory is a Git repository"
  if not command git rev-parse --git-dir > /dev/null 2>/dev/null
    return 1
  end
end

function git_is_empty -d "Test if a repository is empty"
  git_is_repo; and test -z (command git rev-list -n 1 --all 2>/dev/null)
end

function git_is_dirty -d "Test if there are changes not staged for commit"
  git_is_repo; and not command git diff --no-ext-diff --quiet --exit-code 2>/dev/null
end

function git_is_detached_head -d "Test if the repository is in a detached HEAD state"
  git_is_repo; and not command git symbolic-ref HEAD 2>/dev/null > /dev/null
end

