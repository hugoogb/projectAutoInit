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
  source $HOME/projectAutoInit/create.sh

  SOURCE_CREATE_EXISTS_ZSH=`cat .zshrc | grep 'source $HOME/projectAutoInit/create.sh'`
  SOURCE_CREATE_EXISTS_BASH=`cat .bashrc | grep 'source $HOME/projectAutoInit/create.sh'`

  if [ -e $HOME/.zshrc ]; then
    if [ ! $SOURCE_CREATE_EXISTS_ZSH ]; then
      echo "source $HOME/projectAutoInit/create.sh" >> $HOME/.zshrc
    fi
  else
    if [ ! $SOURCE_CREATE_EXISTS_BASH ]; then
      echo "source $HOME/projectAutoInit/create.sh" >> $HOME/.bashrc
    fi
  fi
}

main() {
  clone_repo
  install_requirements
  env_setup
  source_command
}

main
