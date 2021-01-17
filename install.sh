#!/bin/bash

clone_repo() {
  # if [ -d $HOME/.ssh ]; then
    # git clone git@github:hugoogb/projectAutoInit.git $HOME/projectAutoInit
  # else
    git clone https://github.com/hugoogb/projectAutoInit.git $HOME/projectAutoInit
  # fi

  cd $HOME/projectAutoInit
}

install_requirements() {
  pip install -r requirements.txt
}

env_setup() {
  touch $HOME/.env

  echo "GITHUB_TOKEN=" >> $HOME/.env
  echo "PROJECTS_PATH=" >> $HOME/.env
}

source_command() {
  ln -sf $HOME/projectAutoInit/create.sh $HOME/.local/bin/create
}

main() {
  clone_repo
  env_setup
  source_command
}

main
