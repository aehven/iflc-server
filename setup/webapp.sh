#!/bin/bash

function resource {
  source $SERVER_HOME/setup/webapp.sh
}

function gos {
  cd $SERVER_HOME
}

function goc {
  cd $CLIENT_HOME
}

function cls {
  alias cls='printf "\033c"'
}

function mem {
    ps -e -orss=,args= | sort -b -k1,1n | pr -TW$COLUMNS;
    free -h
}

function mem_mon {
  interval=$1
  if [[ -z $interval ]]; then
    interval=3
  fi

  echo "Checking every $interval seconds."

  while [[ 1 ]]; do
    mem > /tmp/mem
    cat /tmp/mem|grep -e "rails s.*3000"|grep -v grep|awk '{printf "Org: %d\t", $1}'
    echo
    sleep $interval
  done
}

function killBranch {
  git branch -d "$1"
  git push origin :"$1"
}

function prune {
  git remote prune origin
}

function genreset {
  cd $SERVER_HOME
  rake db:drop db:create db:migrate db:seed
  mysqldump -uaehven -pcypress ${BASE_NAME}_develop > reset.sql
}

function dbreset {
  JUST_RESET=false

  if [[ ! -f $SERVER_HOME/reset.sql ]]
    then
    genreset
    JUST_RESET=true
  fi

  case $1 in
    staging)
      mysql -utt6bxzpl510ca1m2 -pkp332o9ghgj93mhg -hd6ybckq58s9ru745.cbetxkdyhwsb.us-east-1.rds.amazonaws.com --database kcjskqh71z2lg845 < reset.sql
      ;;
    test)
      # mysql -usxyphmel0m1m0qud -pyxd7hpyvv2z9i0bc -hbqmayq5x95g1sgr9.cbetxkdyhwsb.us-east-1.rds.amazonaws.com --database cdhf9b99aml66wq5 < reset.sql
      ;;
    *)
      if [[ "$JUST_RESET" != "true" ]]; then
        mysql -uaehven -pcypress --database ${BASE_NAME}_develop < reset.sql
      fi
      ;;
  esac

  echo "Database reset."
}

export DISALLOWED_CODE='byebug|logger.*#{params}|debugger|binding.pry'

function isDisallowedCodeUsed {
  result=`find $SERVER_HOME -type f -name "*.*rb" -o -name "*.*js" -not -path "*\.bundle/*" -not -path "*\bower_components/*" -exec grep -Eln $DISALLOWED_CODE {} \;`

  if [[ ! -z "$result" ]]; then
    echo "***************************************************"
    echo "************** DEPLOYMENT CANCELLED ***************"
    echo "***************************************************"
    echo "***** There are calls to disallowed code in:  *****"
    echo "$result"
    echo "***************************************************"
    return 0
  else
    return 1
  fi
}

function simplify_string() {
  x=$1

  #remove spaces
  x="${x//+([[:space:]])/}"

  #remove color codes
  case $(uname -s) in
    Linux)
      x=$(echo $x|sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g")
      ;;
    Darwin)
      x=$(echo $x|sed -E "s/"$'\E'"\[([0-9]{1,2}(;[0-9]{1,2})*)?m//g")
      ;;
  esac

  echo $x
}

function stringify_git_st() {
  st=$(git status --porcelain)
  st=$(simplify_string "$st")
  echo "$st"
}

function stringify_git_origin_diff() {
  d=$(git --no-pager diff $BRANCH origin/$BRANCH)
  d=$(simplify_string "$d")
  echo "$d"
}

function stringify_git_unpushed() {
  u=$(git log @{u}..)
  u=$(simplify_string "$u")
  echo "$u"
}

function codeCheck {
  echo -n "Checking git st.... "
  if [[ $(stringify_git_st) != "" ]]; then
      echo "Uncommitted changes!"
      return 1
  fi
  echo "OK."

  echo -n "Checking git unpushed commits.... "
  if [[ $(stringify_git_unpushed) != "" ]]; then
      echo "Unpushed changes!"
      return 1
  fi
  echo "OK."

  echo "Looking for disallowed code.... "
  if isDisallowedCodeUsed; then
    return 1
  fi
  echo "OK"

  return 0
}

function deploy_usage {
  echo "deploy -a<aehven|test|staging|production> -bbranch [-lm]"
}

function deploy {
  local OPTIND;
  unset APP;
  unset BRANCH;
  unset NOMIGRATE;
  unset NOLOG;
  while getopts "a:b:lm" opt; do
    case "${opt}" in
      a)
          APP=${OPTARG};
          [[ $APP == "aehven" || $APP == "test" || $APP == "staging" || $APP == "production" ]] || unset APP
      ;;
      b)
          BRANCH=${OPTARG}
      ;;
      l)
          NOLOG=true
      ;;
      m)
          NOMIGRATE=true
      ;;
      *)
          deploy_usage
      ;;
    esac;
  done;

  shift $((OPTIND-1));

  if [[ -z $APP || -z $BRANCH ]]; then
      deploy_usage;
      return 1;
  fi;

  DEPLOY_NAME=$BASE_NAME
  ENV_NAME=prod

  if [[ $APP != "production" ]]; then
    DEPLOY_NAME="${DEPLOY_NAME}-${APP}"
    ENV_NAME=$APP
  fi

  echo $DEPLOY_NAME

  #check out the branch to deploy, same branch must exist
  #in client and server.
  goc
  git co $BRANCH
  gos
  git co $BRANCH

  #build client
  goc
  ng build --prod --aot=true -env=$ENV_NAME

  #put the build in a deployment branch
  gos

  git branch -D deployment
  git push origin :deployment
  git co -b deployment $BRANCH

  #copy built client to server/public
  mkdir -p public
  cp -rp ../client/dist/* public/.
  git add .

  git push -u origin deployment
  git commit -am "deployment"

  git push -f $DEPLOY_NAME deployment:master

  heroku run bundle exec rake db:migrate -a$DEPLOY_NAME
  heroku logs --tail -a$DEPLOY_NAME
}

function tmuxinit {
  tmux start-server
  tmux new-session -d -s webapp
  tmux new-window -t webapp:1 -n mysql
  tmux new-window -t webapp:2 -n rails-c
  tmux new-window -t webapp:3 -n rails-server
  tmux new-window -t webapp:4 -n rails-bash
  tmux new-window -t webapp:5 -n ng-serve
  tmux new-window -t webapp:6 -n ng-bash


  tmux send-keys -t webapp:1 "webapp; gos; mysql -uaehven -pcypress --database ${BASE_NAME}_develop"
  tmux send-keys -t webapp:2 "webapp; gos; rails c"
  tmux send-keys -t webapp:3 "webapp; gos; rails s -b0.0.0.0 -p3000" C-m
  tmux send-keys -t webapp:4 "webapp; gos" C-m
  tmux send-keys -t webapp:5 "webapp; goc; ng serve --host 0.0.0.0 --port 4200" C-m
  tmux send-keys -t webapp:6 "webapp; goc;" C-m

  tmux select-window -t webapp:5
  tmux attach-session -t webapp
}

function start {
  rm log/development.log; rails s -b0.0.0.0 | tee log/development.log
}

function stop {
  kill -9 $(ps -ef|grep "rails s"|grep -v "rails s"|awk '{print $2}') &> /dev/null
  kill -9 $(ps -ef|grep "puma.*worker"|grep -v "grep"|awk '{print $2}') &> /dev/null
}

echo "SERVER_HOME = $SERVER_HOME"
