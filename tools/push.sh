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
  git remote add origin https://${GITHUB_TOKEN}@github.com/Seniru/LineGraph-TFM.git > /dev/null 2>&1
  git push --quiet --set-upstream origin master 
}

setup_git
commit_website_files
upload_files
