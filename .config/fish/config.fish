fish_add_path /opt/homebrew/bin
fish_add_path /Library/Android/sdk/build-tools/21.1.2
fish_add_path /usr/local/opt/nss/bin

set -gx LIBRARY_PATH "$LIBRARY_PATH:/usr/local/lib"
set -gx JAVA_HOME /opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home

if test -f /opt/homebrew/bin/brew
    eval (/opt/homebrew/bin/brew shellenv)
end

abbr --add --global ls 'ls -GFh'
abbr --add --global c 'clear'
abbr --add --global .. 'cd ..'
abbr --add --global ... 'cd ../../'
abbr --add --global .... 'cd ../../../'
abbr --add --global ..... 'cd ../../../../'
abbr --add --global h 'history'
abbr --add --global mv 'mv -iv'
abbr --add --global cp 'cp -iv'
abbr --add --global ln 'ln -i'
abbr --add --global h 'history'
abbr --add --global ports 'lsof -iTCP -sTCP:LISTEN -n -P'
abbr --add --global myip 'curl -s ifconfig.me'
abbr --add --global weather 'curl -s wttr.in'
abbr --add --global uuid 'uuidgen | tr "[:upper:]" "[:lower:]"'
abbr --add --global serve 'python3 -m http.server 8000'
abbr --add --global json 'jq .'

# System Shortcuts (macOS)
abbr --add --global hidefiles 'defaults write com.apple.finder AppleShowAllFiles NO; killall Finder'
abbr --add --global showfiles 'defaults write com.apple.finder AppleShowAllFiles YES; killall Finder'
abbr --add --global flush 'sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
abbr --add --global cleanup 'find . -type f -name "*.DS_Store" -ls -delete'
abbr --add --global emptytrash 'sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl'
abbr --add --global cpu 'sysctl -n machdep.cpu.brand_string'

# Git Abbreviations
abbr --add --global g 'git'
abbr --add --global gst 'git status -sb'
abbr --add --global gs 'git status -s'
abbr --add --global gl 'git log --oneline --graph --decorate'
abbr --add --global gla 'git log --oneline --graph --decorate --all'
abbr --add --global gp 'git push'
abbr --add --global gf 'git fetch --all --prune'
abbr --add --global gc 'git commit -vm'
abbr --add --global gca 'git commit -vam'
abbr --add --global ga 'git add'
abbr --add --global gb 'git branch'
abbr --add --global gco 'git checkout'
abbr --add --global gcb 'git checkout -b'
abbr --add --global gd 'git diff'
abbr --add --global gdc 'git diff --cached'
abbr --add --global grh 'git reset --hard'
abbr --add --global grs 'git reset --soft'
abbr --add --global gundo 'git reset HEAD~1 --mixed'
abbr --add --global gclean 'git clean -fd'
abbr --add --global gpristine 'git reset --hard && git clean -fdx'

# Docker Abbreviations
abbr --add --global dc 'docker-compose'
abbr --add --global dce 'docker-compose exec'
abbr --add --global dps 'docker ps'
abbr --add --global dpa 'docker ps -a'
abbr --add --global di 'docker images'
abbr --add --global drmi 'docker rmi -f (docker images -f "dangling=true" -q)'
abbr --add --global dexec 'docker exec -it'
abbr --add --global dlog 'docker logs -f'
abbr --add --global dstop 'docker stop'
abbr --add --global dstart 'docker start'
abbr --add --global dclean 'docker system prune -af'

# kubernetes
abbr --add --global k 'kubectl'
abbr --add --global kns 'kubens'
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

# Added by `rbenv init` on Mon  7 Oct 2024 13:17:44 BST
status --is-interactive; and rbenv init - --no-rehash fish | source
