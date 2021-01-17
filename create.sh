#!/bin/bash

SOURCE_DIR=$HOME/projectAutoInit
SSH_DIR=$HOME/.ssh

create() {
  cd $HOME
  source $HOME/.env
  python $SOURCE_DIR/create.py $1
  cd $PROJECTS_PATH$1
  git init
  echo "# $1" > README.md
  echo "/*" > .gitignore
  echo "!README.md" >> .gitignore
  echo "!.gitignore" >> .gitignore
  git add README.md .gitignore

  if [ -d $SSH_DIR ]; then
    git remote add origin git@github.com:$USERNAME/$1.git
  else
    git remote add origin https://github.com/$USERNAME/$1.git
  fi

  git commit -m "Initial commit"
  git push -u origin master
  $EDITOR
}
