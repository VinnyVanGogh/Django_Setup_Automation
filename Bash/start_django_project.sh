#!/usr/bin/env bash

source /Users/vincevasile/Documents/Dev/Bash/Django_Setup/BASH/setup_functions.sh

function start_django_project() {
  local project_name=$1
  local superuser_name="${2:-vince}"
  local superuser_email="${3:-subscriptions@vinny-van-gogh.com}"
  local superuser_password="${4:-vv248563}"
  local GREEN='\033[0;32m'
  local RED='\033[0;31m'
  local NO_COLOR='\033[0m'

  setup_virtual_environment "$project_name"
  if [ $? -ne 0 ]; then
    echo -e "${RED} Failed to set up virtual environment.${NO_COLOR}"
    return 1
  fi
  echo -e  "${GREEN}Virtual environment (${venv_name}) set up successfully.${NO_COLOR}"

  install_packages
  if [ $? -ne 0 ]; then
    echo -e "${RED}Failed to install packages.${NO_COLOR}"
    return 1
  fi
  echo -e  "${GREEN}${package} installed successfully.${NO_COLOR}"

  create_apps
  if [ $? -ne 0 ]; then
    echo -e "${RED}Failed to create apps.${NO_COLOR}"
    return 1
  fi
  echo -e  "${GREEN}${app} created successfully.${NO_COLOR}"

  setup_extra_directories
  if [ $? -ne 0 ]; then
    echo -e "${RED}Failed to set up extra directories.${NO_COLOR}"
    return 1
  fi
  echo -e  "${GREEN}Extra directories set up successfully.${NO_COLOR}"

  create_superuser "$superuser_name" "$superuser_email" "$superuser_password"
  if [ $? -ne 0 ]; then
    echo -e "${RED}Failed to create superuser.${NO_COLOR}"
    return 1
  fi
  echo -e  "${GREEN}Superuser created successfully.${NO_COLOR}"

  setup_github "$project_name"
  if [ $? -ne 0 ]; then
    echo -e "${RED}Failed to set up GitHub.${NO_COLOR}"
    return 1
  fi
  echo -e  "${GREEN}GitHub set up successfully.${NO_COLOR}"

  python_scripts
  if [ $? -ne 0 ]; then
    echo -e "${RED}Failed to run Python scripts.${NO_COLOR}"
    return 1
  fi
  echo -e  "${GREEN}Python scripts ran successfully.${NO_COLOR}"

  github_push "$project_name"
  if [ $? -ne 0 ]; then
    echo -e "${RED}Failed to push to GitHub.${NO_COLOR}"
    return 1
  fi
  echo -e  "${GREEN}Successfully created Django project.${NO_COLOR}"

  start_app
}

start_django_project "$@"