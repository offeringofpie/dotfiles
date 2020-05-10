source $HOME/.cargo/env
set PATH /usr/local/lib/node_modules/nw/nwjs $PATH
set LIBRARY_PATH "$LIBRARY_PATH:/usr/local/lib"

alias ls='ls -GFh'
alias c='clear'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias md='mkdir -pv | cd'
# confirmation #
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
alias h='history'
alias dc='docker-compose'
alias dce='docker-compose exec'

#git aliases
abbr --add --global g 'git'
abbr --add --global gs 'git status -s'
abbr --add --global gl 'git pull'
abbr --add --global gp 'git push'
abbr --add --global gf 'git fetch --all --prune'
abbr --add --global gc 'git commit -vm'
abbr --add --global gca 'git commit -vam'
abbr --add --global ga 'git add'
abbr --add --global gb 'git branch'
abbr --add --global gco 'git checkout'
abbr --add --global gcb 'git checkout -b'
abbr --add --global dc 'docker-compose'

# kubernetes
abbr --add --global k kubectl
abbr --add --global kns kubens
abbr --add --global kd 'kubectl describe'
abbr --add --global kg 'kubectl get'
abbr --add --global kl 'kubectl logs'
abbr --add --global kdp 'kubectl describe pods'
abbr --add --global ke 'kubectl exec -ti'
abbr --add --global kgp 'kubectl get pods'
abbr --add --global klf 'kubectl logs -f'

# other
abbr --add --global yt 'youtube-dl -i -o "%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s"'

function optimize
  ffmpeg -i $argv[1] -c:v libx264 -crf 22 -c:a aac -movflags faststart $argv[2]
end

function search
    history | grep "$argv" | tail -100
end

set -g fish_user_paths "/usr/local/opt/nss/bin" $fish_user_paths
