function git_staged -d "Test if there are changes staged for commit"
  git_repo; and not command git diff --cached --no-ext-diff --quiet --exit-code 2>/dev/null
end