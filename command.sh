#!/bin/bash

create() {
  cd $HOME
  source .env
  python create.py $1
  cd $PROJECTS_PATH$1
  git init
  echo "# $1" > README.md
  echo "/*" > .gitignore
  echo "!README.md" >> .gitignore
  echo "!.gitignore" >> .gitignore
  git add README.md .gitignore
  if [[ -n "$2" ]]
  then
    if [[ "$2" == "-m" -o "$2" == "--me" ]]
    then
      git config user.email "$GITHUB_ME_EMAIL"
      git config user.name "$GITHUB_ME_NAME"
      git remote add origin git@me.github.com:$GITHUB_ME_USERNAME/$1.git
    elif [[ "$2" == "-p" -o "$2" == "--uni" ]]
    then
      git config user.email "$GITHUB_UNI_EMAIL"
      git config user.name "$GITHUB_UNI_NAME"
      git remote add origin git@uni.github.com:$GITHUB_UNI_USERNAME/$1.git
    fi
  else
    git remote add origin git@github.com:$GITHUB_USERNAME/$1.git
  fi
  git commit -m "Initial commit"
  git push -u origin master
  $EDITOR
}
