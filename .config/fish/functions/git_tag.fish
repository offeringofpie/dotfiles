function git_tag -d "Test if HEAD is on top of a tag (can be simple, annotated or signed)"
  git_detached_head; and command git describe --tags --exact-match HEAD 2>/dev/null > /dev/null
end