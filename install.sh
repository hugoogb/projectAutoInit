#!/bin/bash

clone_repo() {
  if [ ! -d $HOME/projectAutoInit ]; then
    if [ -d $HOME/.ssh ]; then
      git clone git@github.com:hugoogb/projectAutoInit.git $HOME/projectAutoInit
    else
      git clone https://github.com/hugoogb/projectAutoInit.git $HOME/projectAutoInit
    fi
  else
    cd $HOME/projectAutoInit
    git pull origin master
  fi
}

install_requirements() {
  pip install -r $HOME/projectAutoInit/requirements.txt
}

env_setup() {
  if [ ! -e $HOME/.env ]; then
    touch $HOME/.env
  fi

  GITHUB_USERNAME_EXISTS=`cat ~/.env | grep 'GITHUB_USERNAME'`
  GITHUB_TOKEN_EXISTS=`cat ~/.env | grep 'GITHUB_TOKEN'`
  GITHUB_PROJECTS_PATH_EXISTS=`cat ~/.env | grep 'GITHUB_PROJECTS_PATH'`

  if [ ! $GITHUB_USERNAME_EXISTS ]; then
    echo "GITHUB_USERNAME" >> $HOME/.env
  fi
  if [ ! $GITHUB_TOKEN_EXISTS ]; then
    echo "GITHUB_TOKEN=" >> $HOME/.env
  fi
  if [ ! $GITHUB_PROJECTS_PATH_EXISTS ]; then
    echo "GITHUB_PROJECTS_PATH=" >> $HOME/.env
  fi
}

source_command() {
  ln -sf $HOME/projectAutoInit/create.sh $HOME/.local/bin/create
}

main() {
  clone_repo
  install_requirements
  env_setup
  source_command
}

main
