function git_empty -d "Test if a repository is empty"
  git_repo; and test -z (command git rev-list -n 1 --all 2>/dev/null)
end