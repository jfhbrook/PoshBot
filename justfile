set dotenv-load := true
set shell := ["pwsh", "-c"]

install:
  scripts/Install.ps1
  npm install

update:
  $has_upstream_remote = $false; git remote -v | ForEach-Object { if ($_ -match '^upstream') { $has_upstream_remote = $true } }; if (-not $has_upstream_remote) { git remote add upstream git@github.com:poshbotio/PoshBot.git }
  $current_branch = "$(git branch --show-current)"; git checkout main; git pull upstream master; git checkout "$current_branch"

build:
  .\build.ps1 -Task Build

lint:
  .\build.ps1 -Task Analyze

test:
  .\build.ps1 -Task Pester

console:
  pwsh -NoExit -Command "& ./scripts/Activate.ps1; $ErrorActionPreference = 'Continue'"
