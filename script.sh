#!/bin/bash

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Function to display an error message
function error() {
  echo -e "${RED}${BOLD}ERROR: $1${NC}" >&2
  exit 1
}

# Asks for the commit type and checks if the type is valid
for i in {1..3}
do
  echo -e "${GREEN}${BOLD}What type is it? (feat, bug, doc...)${NC}"
  echo -e "${YELLOW}Options are: feat, bug, doc, chore, style, refactor, test, perf, ci, build${NC}"
  read type

  if [[ "$type" =~ ^(feat|bug|doc|chore|style|refactor|test|perf|ci|build)$ ]]; then
    break
  else
    echo -e "${RED}The commit type must be one of the following: feat, bug, doc, chore, style, refactor, test, perf, ci, build.${NC}"
    if [[ $i -eq 3 ]]; then
      exit 1
    fi
  fi
done

# Asks for the commit scope
echo -e "${GREEN}${BOLD}In which scope? (auth, api, db...)${NC}"
read scope

# Asks for a description of the commit
echo -e "${GREEN}${BOLD}A description?${NC}"
read description

# Asks if there are breaking changes
for i in {1..3}
do
  echo -e "${GREEN}${BOLD}Are there any breaking changes? (y/n)${NC}"
  read breaking_changes

  if [[ "$breaking_changes" =~ ^(y|Y|n|N)$ ]]; then
    break
  else
    echo -e "${RED}Please answer with y or n.${NC}"
    if [[ $i -eq 3 ]]; then
      exit 1
    fi
  fi
done

# Asks for a body for the commit (optional)
echo -e "${GREEN}${BOLD}A body?${NC}"
read body

# Asks for a footer for the commit (optional)
echo -e "${GREEN}${BOLD}Reference to a PR or an issue? (123)${NC}"
read pr

# Génère le message de commit
if [ -z "$scope" ]; then
  message="$type"
else
  message="$type($scope)"
fi

if [[ "$breaking_changes" =~ ^(y|Y)$ ]]; then
  message="$message!"
fi

message="$message: $description"

if [ ! -z "$body" ]; then
  message="$message"$'\n\n'"$body"
fi

if [ ! -z "$pr" ]; then
  footer="Close #$pr"
  message="$message"$'\n\n'"$footer"
fi

# Shows the commit message
echo -e "${YELLOW}${BOLD}Commit message:${NC}"
echo -e "$message"

# Asks for confirmation
echo -e "${GREEN}${BOLD}Do you want to commit this? (y/n)${NC}"
read confirm

# Commits the changes
if [[ "$confirm" =~ ^(y|Y)$ ]]; then
  git commit -m "$message"
  echo -e "${GREEN}${BOLD}Changes committed!${NC}"
else
  echo -e "${RED}${BOLD}Changes not committed!${NC}"
fi