# https://itectec.com/unixlinux/bash-how-to-save-the-last-command-to-a-file/
lc() {
    fc -ln "$1" "$1" | sed '1s/^[[:space:]]*//'
}

fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

gh() {
    git remote -v | grep push
    remote=${1:-origin}
    echo "Using remote $remote"
    URL=$(git config remote.$remote.url | sed "s/git@\(.*\):\(.*\).git/https:\/\/\1\/\2/")
    echo "Opening $URL..."
    open $URL
} 

jwt_decode(){
    token=$1
    echo $token | jq -R 'split(".") | .[0:2] | map(. | @base64d) | map(. | fromjson)'
}

cc_servers_stg(){
    aws ec2 describe-instances --filters 'Name=instance-state-code,Values=16' --query 'Reservations[*].Instances[*].[InstanceId, PrivateIpAddress, Tags[?Key==`Name`] | [0].Value]' --output table | grep webapp.monolith.staging
}

cc_servers_prod(){
    aws ec2 describe-instances --filters 'Name=instance-state-code,Values=16' --query 'Reservations[*].Instances[*].[InstanceId, PrivateIpAddress, Tags[?Key==`Name`] | [0].Value]' --output table | grep webapp.monolith.production
}

cc_servers_zoo() {
    aws ec2 describe-instances --filters 'Name=instance-state-code,Values=16' --query 'Reservations[*].Instances[*].[InstanceId, PrivateIpAddress, Tags[?Key==`Deploy_Namespace`] | [0].Value]' --output table | grep -v None
}

cc_find_stg_server() {
    aws ec2 describe-instances --filters 'Name=instance-state-code,Values=16' --query 'Reservations[*].Instances[*].[InstanceId, PrivateIpAddress, Tags[?Key==`Name`] | [0].Value]' --output json | jq -r '[.[][] | select(.[2] != null) | select(.[2]|test("webapp.monolith.staging")) | .[0]][0]'
}

cc_find_prod_server() {
    aws ec2 describe-instances --filters 'Name=instance-state-code,Values=16' --query 'Reservations[*].Instances[*].[InstanceId, PrivateIpAddress, Tags[?Key==`Name`] | [0].Value]' --output json | jq -r '[.[][] | select(.[2] != null) | select(.[2]|test("webapp.monolith.production")) | .[0]][0]'
}

cc_ssh() {
    instance_id=$1
    aws ssm start-session --target "$instance_id"
}

cc_ssh_stg() {
    local iid=$(cc_find_stg_server)
    echo "Found staging instance $iid"
    aws ssm start-session --target "$iid"
}

cc_ssh_prod() {
    local iid=$(cc_find_prod_server)
    echo "Found production instance $iid"
    aws ssm start-session --target "$iid"
}
