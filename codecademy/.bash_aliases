# general
alias .....='cd ../../../../'
alias ....='cd ../../../../'
alias ...='cd ../../../'
alias ..='cd ..'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'
alias c="clear"
alias ls="ls --color -l"
alias sdb='python /Users/alin/src/dbconf/main.py'
alias tilt=/usr/local/bin/tilt
alias watch='watch '
alias v='vim '

# quick navs
alias gwiki='cd $HOME/src/wiki && vim index.wiki'
alias gcsv4='cd $HOME/src/content_service_v4'
alias gauthor='cd $HOME/src/author'
alias gcodecademy='cd $HOME/src/codecademy'

# tmux
alias tx='tmuxinator'
alias txs='tmuxinator start'
alias txe='tmuxinator stop'

# dotfiles
alias rebash='source ~/.bash_profile'
alias reload="source ~/.bash_profile"
alias valiases="vim ~/.bash_aliases"
alias vprofile="vim ~/.bash_profile"
alias vfunctions="vim ~/.bash_functions"

# kubernetes
alias kc='kubectl'
alias kconf='kubectl config '
alias kconfig='kubectl config '
alias kcl='kubectl logs '
alias kcd='kubectl describe '
alias kcg='kubectl get '
alias kcp='kubectl get pods '
alias kcd='kubectl get deployments '
alias kdp='kubectl describe pod'
alias kce='kubectl exec -it '

# git
alias ga='git add '
alias gb='git branch '
alias gba='git for-each-ref --format="%(committerdate) %09 %(authorname) %09 %(refname)"'
alias gbisect='git bisect '
alias gc='git commit'
alias gco='git checkout '
alias gcob='git checkout -b '
alias gd='git diff'
alias get='git '
alias gf='git fetch --all'
alias gk='gitk --all&'
alias gl='git log --oneline'
alias glp='git log --pretty=format:"%Cred%h%Creset - %C(bold blue)<%an>%Creset %Cgreen(%cr)%Creset %C(cyan)- %C(reset)%s %C(yellow)%d%Creset" --abbrev-commit --date=relative --color=always'
alias got='git '
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpull='git pull'
alias gpul='git pull'
alias gpush='git push'
alias gri='git rebase -i '
alias gs='git status '
alias gstash='git stash'
alias gclean='git clean -f'
alias gx='gitx --all'

# ruby
alias bexec='bundle exec'
alias be='bundle exec'

# docker compose
alias dc='docker compose'
alias dcr='docker compose run'
alias dce='docker compose exec '
alias dps='docker ps'
alias dpsa='docker ps -a'
alias dprune='docker system prune'

# codecademy tooling
alias ve='aws-vault exec'
alias vp='aws-vault exec prod && kubectx production-blue'
alias vn='aws-vault exec nonprod && kubectx staging-blue' 
alias kns='kubens '
alias kctx='kubectx '
alias kctxd='kubectx development-blue'
alias kctxp='kubectx production-blue'
alias kctxs='kubectx staging-blue'
alias csv4test='docker compose run --rm web bundle exec'
alias csv4rc='docker compose exec web bundle exec rails console' # rails console
alias kcsv4rc='kubectl exec -it deploy/contentv4 -- bundle exec rails console'
alias jic='jira issue create'

# rails csv4
alias dspec='docker-compose exec web bundle exec rspec '
