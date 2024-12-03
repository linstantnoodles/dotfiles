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

convert_unix_date() {
    date -d @"$1" +'%Y-%m-%d %H:%M:%S'
}

gh() {
    git remote -v | grep push
    remote=${1:-origin}
    echo "Using remote $remote"
    URL=$(git config remote.$remote.url | sed "s/git@\(.*\):\(.*\).git/https:\/\/\1\/\2/")
    echo "Opening $URL..."
    open $URL
} 

kcpm() {
    kubectl get po -o jsonpath='{range .items[*]}{"pod: "}{.metadata.name}{"\n"}{range .spec.containers[*]}{"\tname: "}{.name}{"\n\timage: "}{.image}{"\n"}{end}'
}

jwtd(){
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

zoo_ssh() {
  if [ -z $1 ]
  then 
  	echo "Err: Must specify a zoo server name"
  else
    instanceid=$(aws-vault exec nonprod -- \
     aws ec2 describe-instances --query \
     'Reservations[*].Instances[*].[InstanceId, Tags[?Key==`Deploy_Namespace`] | [0].Value]' \
     --filters "Name=tag:Deploy_Namespace,Values=$1" --output text | cut -f 1)
    if [ -z "$instanceid" ]
    then
  	  echo "Could not find InstanceId for $1"
    else
      echo "Found InstanceId for $1 to be $instanceid"
      aws-vault exec nonprod -- aws ssm start-session --target $instanceid
    fi
  fi
}

staging_ssh () {
  instanceid=$(aws-vault exec nonprod -- \
   aws ec2 describe-instances --query \
   'Reservations[*].Instances[*].[InstanceId, Tags[?Key==`Name`] | [0].Value]' \
    --output text | grep webapp.monolith.staging | cut -f 1 | head -n 1)
  if [ -z "$instanceid" ]
  then
    echo "Could not find InstanceId for staging"
  else
    echo "Found InstanceId for staging to be $instanceid"
    aws-vault exec nonprod -- aws ssm start-session --target $instanceid
  fi
}

prod_ssh() {
  instanceid=$(aws-vault exec prod -- \
   aws ec2 describe-instances --query \
   'Reservations[*].Instances[*].[InstanceId, Tags[?Key==`Name`] | [0].Value]' \
    --output text | grep webapp.monolith.production.us-east-1.asg | cut -f 1 | head -n 1)
  if [ -z "$instanceid" ]
  then
    echo "Could not find InstanceId for production"
  else
    echo "Found InstanceId for production to be $instanceid"
    aws-vault exec prod -- aws ssm start-session --target $instanceid
  fi
}

lnvm() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"
  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
