
fish_add_path /opt/homebrew/bin
fish_add_path /usr/local/opt/nss/bin

set -gx LIBRARY_PATH "$LIBRARY_PATH:/usr/local/lib"
set -gx JAVA_HOME /opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home

if test -f /opt/homebrew/bin/brew
    eval (/opt/homebrew/bin/brew shellenv)
end

alias ls='ls -GFh'
alias mv='mv -iv'
alias cp='cp -iv'
alias ln='ln -i'

abbr --add --global c 'clear'
abbr --add --global .. 'cd ..'
abbr --add --global ... 'cd ../../'
abbr --add --global .... 'cd ../../../'
abbr --add --global ..... 'cd ../../../../'
abbr --add --global h 'history'
abbr --add --global ports 'lsof -iTCP -sTCP:LISTEN -n -P'
abbr --add --global myip 'curl -s ifconfig.me'
abbr --add --global weather 'curl -s wttr.in'
abbr --add --global uuid 'uuidgen | tr "[:upper:]" "[:lower:]"'
abbr --add --global serve 'python3 -m http.server 8000'
abbr --add --global json 'jq .'
abbr --add --global yt 'yt-dlp -i -o "%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s"'

abbr --add --global hidefiles 'defaults write com.apple.finder AppleShowAllFiles NO; killall Finder'
abbr --add --global showfiles 'defaults write com.apple.finder AppleShowAllFiles YES; killall Finder'
abbr --add --global flush 'sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
abbr --add --global cleanup 'find . -type f -name "*.DS_Store" -ls -delete'
abbr --add --global emptytrash 'sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl'
abbr --add --global cpu 'sysctl -n machdep.cpu.brand_string'

abbr --add --global g 'git'
abbr --add --global gst 'git status -sb'
abbr --add --global gs 'git status -s'
abbr --add --global gl 'git log --oneline --graph --decorate'
abbr --add --global gla 'git log --oneline --graph --decorate --all'
abbr --add --global gp 'git push'
abbr --add --global gpu 'git push -u origin HEAD'
abbr --add --global gpf 'git push --force-with-lease'
abbr --add --global gf 'git fetch --all --prune'
abbr --add --global gc 'git commit -vm'
abbr --add --global gca 'git commit -vam'
abbr --add --global ga 'git add'
abbr --add --global gb 'git branch'
abbr --add --global gco 'git checkout'
abbr --add --global gcb 'git checkout -b'
abbr --add --global gsw 'git switch'
abbr --add --global gswc 'git switch -c'
abbr --add --global gd 'git diff'
abbr --add --global gdc 'git diff --cached'
abbr --add --global grh 'git reset --hard'
abbr --add --global grs 'git reset --soft'
abbr --add --global gundo 'git reset HEAD~1 --mixed'
abbr --add --global gclean 'git clean -fd'
abbr --add --global gpristine 'git reset --hard && git clean -fdx'
abbr --add --global gwip 'git add -A && git commit -m "wip"'
abbr --add --global gstash 'git stash push -m'
abbr --add --global gpop 'git stash pop'

abbr --add --global dc 'docker-compose'
abbr --add --global dce 'docker-compose exec'
abbr --add --global dps 'docker ps'
abbr --add --global dpa 'docker ps -a'
abbr --add --global di 'docker images'
abbr --add --global dexec 'docker exec -it'
abbr --add --global dlog 'docker logs -f'
abbr --add --global dstop 'docker stop'
abbr --add --global dstart 'docker start'
abbr --add --global dclean 'docker system prune -af'

abbr --add --global k 'kubectl'
abbr --add --global kns 'kubens'
abbr --add --global kd 'kubectl describe'
abbr --add --global kg 'kubectl get'
abbr --add --global kl 'kubectl logs'
abbr --add --global kdp 'kubectl describe pods'
abbr --add --global ke 'kubectl exec -ti'
abbr --add --global kgp 'kubectl get pods'
abbr --add --global klf 'kubectl logs -f'

function optimize -d "Re-encode video for streaming with x264"
    ffmpeg -i $argv[1] -c:v libx264 -crf 22 -c:a aac -movflags faststart $argv[2]
end

function search -d "Search shell history"
    history | grep "$argv" | tail -100
end

function drmi -d "Remove dangling docker images safely"
    set -l dangling (docker images -f "dangling=true" -q)
    if test -n "$dangling"
        docker rmi -f $dangling
    else
        echo "No dangling images to remove."
    end
end

function mkcd -d "Make directory and cd into it"
    mkdir -p $argv[1]; and cd $argv[1]
end

function extract -d "Extract any common archive type"
    if test -z "$argv[1]"
        echo "Usage: extract <archive>"
        return 1
    end
    switch $argv[1]
        case '*.tar.bz2'; tar xjf $argv[1]
        case '*.tar.gz';  tar xzf $argv[1]
        case '*.tar.xz';  tar xJf $argv[1]
        case '*.tar';     tar xf $argv[1]
        case '*.zip';     unzip $argv[1]
        case '*.gz';      gunzip $argv[1]
        case '*.bz2';     bunzip2 $argv[1]
        case '*.7z';      7z x $argv[1]
        case '*';         echo "Cannot extract $argv[1]"
    end
end