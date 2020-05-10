function git_dirty -d "Test if there are changes not staged for commit"
  git_repo; and not command git diff --no-ext-diff --quiet --exit-code 2>/dev/null
end