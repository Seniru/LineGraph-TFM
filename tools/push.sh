#!/bin/sh

setup_git() {
  git config --global user.email "senirupasan@gmail.com"
  git config --global user.name "Seniru"
}

commit_website_files() {
  git add .
  git commit --message "ci: Automated build"
}

upload_files() {
  git remote add origin https://github.com/Seniru/LineGraph-TFM.git
  git push --quiet --set-upstream origin
}

setup_git
commit_website_files
upload_files
