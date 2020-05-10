function git_dirty_files -f "Get the number of files not staged for commit"
  set -l dirty (command git status -s --ignore-submodules=dirty | wc -l | sed -e 's/^ *//' -e 's/ *$//' 2> /dev/null)

  return $dirty
end