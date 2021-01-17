#!/bin/bash

create() {
  cd $HOME/projectAutoInit
  source $HOME/.env
  python create.py $1
}

git_init() {
  cd $PROJECTS_PATH$1
  git init
  echo "# $1" > README.md
  echo "/*" > .gitignore
  echo "!README.md" >> .gitignore
  echo "!.gitignore" >> .gitignore
  git add README.md .gitignore

  if [ -d $HOME/.ssh ]; then
    git remote add origin git@github.com:$USERNAME/$1.git
  else
    git remote add origin https://github.com/$USERNAME/$1.git
  fi

  git commit -m "Initial commit"
  git push -u origin master
  $EDITOR
}

main() {
  create
  git_init
}

main
