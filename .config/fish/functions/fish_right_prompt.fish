
function get_git_status -d "Gets the current git status"
  if git_repo
    set -l dirty (command git status -s --ignore-submodules=dirty | wc -l | sed -e 's/^ *//' -e 's/ *$//' 2> /dev/null)


    if [ "$dirty" != "0" ]
      set_color -b normal
      set_color yellow
      echo "$dirty changed file"
      if [ "$dirty" != "1" ]
        echo "s"
      end
    end
    set_color normal
  end
end

function fish_right_prompt -d "Prints right prompt"
  get_git_status
end
