#!/bin/bash

create() {
  source $HOME/.env
  cd $HOME/projectAutoInit
  python create.py $1
  cd $GITHUB_PROJECTS_PATH$1

  git init
  echo "# $1" > README.md
  echo "/*" > .gitignore
  echo "!README.md" >> .gitignore
  echo "!.gitignore" >> .gitignore
  git add README.md .gitignore
  git commit -m "Initial commit"

  if [ -d $HOME/.ssh ]; then
    git remote add origin git@github.com:$GITHUB_USERNAME/$1.git
  else
    git remote add origin https://github.com/$GIHUB_USERNAME/$1.git
  fi

  git branch -M master
  git push -u origin master
}
