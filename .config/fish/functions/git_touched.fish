function git_touched -d "Test if there are any changes in the working tree"
  git_staged; or git_dirty
end