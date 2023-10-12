#!/usr/bin/env bash

project_name=$1

function setup_virtual_environment() {
  django-admin startproject "$project_name"
  cd "$project_name" || return 1
  create_env () {
    venv_name=".venv_$project_name"
    created=false
    if [ ! -d "$venv_name" ]
    then
        python3 -m venv "$venv_name"
        created=true
    fi
    source "$venv_name/bin/activate"
    if [ $? -eq 0 ]
    then
        yellow=$(tput setaf 3)
        green=$(tput setaf 2)
        red=$(tput setaf 1)
        reset=$(tput sgr0)
        if [ "$created" = true ]
        then
            echo "${green}Created and activated venv:${yellow} $venv_name | ${red}run 'deactivate or denv' to exit.${reset}"
        else
            echo "${green}Activated venv:${yellow} $venv_name | ${red}run 'deactivate or denv' to exit.${reset}"
        fi
    else
        echo "Failed to activate virtual environment."
        return 1
    fi
}
  create_env
  if [ $? -ne 0 ]; then
    echo "Failed to set up virtual environment."
    return 1
  fi
}

function install_packages() {
  pip install --upgrade pip
  packages=(
    "django"
    "argparse"
    "djangorestframework"
    "django-crispy-forms"
    "django-filter"
    "django-allauth"
    "django-oauth-toolkit"
    "python-decouple"
    "django-secure"
    "django-debug-toolbar"
    "django-cachalot"
    "django-storages"
    "django-compressor"
    "django-webpack-loader"
    "pytest-django"
    "django-cors-headers"
    "opencv-python"
    "python-dotenv"
    "Pillow"
  )

  for package in "${packages[@]}"; do
    pip install "$package"
    if [ $? -ne 0 ]; then
      echo "Failed to install $package."
      exit 1
    fi
  done
}

function create_apps() {
  mkdir -p backend/{core,api,utilities,generic}
  for app in core api utilities generic; do
    python3 manage.py startapp $app ./backend/$app
  if [ $? -ne 0 ]; then
    echo "Failed to create app '$app'."
    return 1
  fi
  done
}

function setup_extra_directories() {
cat <<EOF > .env
DEBUG=True
DJANGO_SECRET_KEY=$(python3 -c 'import secrets; print(secrets.token_hex(50))')
#DBUSER=
#DBPASSWORD=
DBHOST=
DBPORT=
#EMAIL_HOST_USER= 
#EMAIL_HOST_PASSWORD= 
#OPEN_API_KEY= 
#AZURE_CREDENTIALS= 
#GRAPH_CLIENT_ID= 
#DB_CONNECTION_STRING= 
EOF

  mkdir -p frontend/templates/{layout,includes} frontend/static/{css,js,img} frontend/media/{images,videos}
  pip freeze > requirements.txt
}

function create_superuser() {
  local superuser_name="${2:-vince}"
  local superuser_email="${3:-subscriptions@vinny-van-gogh.com}"
  local superuser_password="${4:-vv248563}"
  python3 manage.py makemigrations
  python3 manage.py migrate
  echo "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser('$superuser_name', '$superuser_email', '$superuser_password')" | python manage.py shell
}

function setup_github() {
  git init
  curl https://raw.githubusercontent.com/github/gitignore/master/Python.gitignore > .gitignore
  echo -e ".venv*\nvideos/\n*.log\n" >> .gitignore
  echo "$venv_name" >> .gitignore
  touch README.md
cat <<EOL >> README.md
# $project_name
## Table of Contents
- [Prerequisites](#prerequisites)
- [Description](#description)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)
## Prerequisites
## Description
## Installation
## Usage
## Contributing
## License
EOL
}

function python_scripts() {
    python_scripts=(
    "modify_django_settings.py"
    "modify_generic_views.py"
    "modify_generic_urls.py"
    "modify_django_settings.py"
    "modify_main_urls.py"
    "add_base_urls.py"
    "add_base_html.py"
    "modify_app_names.py"
)

  for script in "${python_scripts[@]}"; do
    python3 "/Users/vincevasile/Documents/Dev/Bash/Django_Setup/PYTHON/$script" -p "$project_name"
  done
}

function github_push() {
  gh repo create "$project_name" --private -y
  if [ $? -ne 0 ]; then
    echo "Failed to create GitHub repository."
    return 1
  fi

  git add .
  git commit -m "Initial commit"
  git branch -M main
  git push -u origin main
  echo "Repository '$project_name' created and pushed successfully."
}

function start_app() {
  code .
  python3 manage.py runserver
}