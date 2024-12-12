#!/usr/bin/env bash
vendir sync
. vendir/demo-magic/demo-magic.sh
export TYPE_SPEED=100
export DEMO_PROMPT="${GREEN}➜ ${CYAN}\W ${COLOR_RESET}"
#export PROMPT_TIMEOUT=5
export JAVA_8=8.0.432-librca
export JAVA_17=17.0.13-librca

function talkingPoint() {
  wait
  clear
}

function initSDKman() {
	if [[ -f "$SDKMAN_DIR/bin/sdkman-init.sh" ]]; then
   	  source "$SDKMAN_DIR/bin/sdkman-init.sh"  
  else
      echo "SDKMAN_DIR is not set, using default location"
  	  source "$HOME/.sdkman/bin/sdkman-init.sh"  
	fi
	sdk env install
}

function init {
  rm -rf upgrade-example
  mkdir upgrade-example
  cd upgrade-example || exit
  clear
}

function git_init {
  git clone git@github.com:pivotal/spring-boot-migrator-jee-projects.git ./
}

function useJava17 {
  echo "#### Use Java 17"
  echo ""
  pei "sdk use java $JAVA_17"
  pei "java -version" 
}

function SBMapply {
  pei "cd .."
  pei "pwd"
  pei "cp ./vendir/sprint-boot-migrator/spring-boot-migrator.jar  ./"
  pei "java -Dsbm.gitSupportEnabled=false -jar spring-boot-migrator.jar @apply.txt"
}

function log {
  pei "cd upgrade-example"
  pei "git log"
}

function diff {
  pei "git diff"
}

initSDKman
init
git_init
talkingPoint
useJava17
talkingPoint
SBMapply
talkingPoint
log
talkingPoint
diff
