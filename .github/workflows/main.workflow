workflow "Build" {
  on = "push"
  resolves = ["Minify"]
}

action "Install Dependencies" {
  uses = "actions/npm@master"
  args = "install -g luamin"
}

action "Minify" {
  uses = "actions/npm@master"
  needs = "Install Dependencies"
  args = "luamin -f .../linegraph.lua"
}

