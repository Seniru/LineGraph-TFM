workflow "Build" {
  on = "push"
  resolves = ["Install Dependencies"]
}

action "Install Dependencies" {
  uses = "actions/npm@master"
  args = "install -g luamin & luamin -f .../linechart.lua"
}
