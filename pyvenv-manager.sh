#! /bin/bash

PYVENV_MGR_VERSION="0.0.1"

windows() { [ -n "$WINDIR" ]; }

create() {
  if [ -z "$1" ]; then
    target_dir="$HOME/.pyvenvs/venvs/$(basename pwd)"
  elif [ "$1" == "--local" ]
    target_dir="venv"
  else
    target_dir="$HOME/.pyvenvs/venvs/$1"
  fi
  python3 -m venv "$target_dir"
}

venv_detect() {
  env_dir="$1"

  if windows; then
    py_exe="$env_dir/Scripts/python"
  else
    py_exe="$env_dir/bin/python"
  fi

  if [ -f "$py_exe" ]; then
    echo "Python virtual environment available at $env_dir"
  else
    echo "No Python virtual environment available at $env_dir"
    exit 1
  fi
}

activate() {
  if [ -d "$(pwd)/venv" ]; then
    env_dir="$(pwd)/venv"
  elif [ -z "$1" ]; then
    env_dir="$HOME/.pyvenvs/venvs/$(basename pwd)"
  else
    env_dir="$HOME/.pyvenvs/venvs/$1"
  fi

  venv_detect $env_dir

  if windows; then
    . $env_dir/Scripts/activate
  else
    . $env_dir/bin/activate
  fi
}

manager() {
  case $1 in
    "--version" | "-v" )
      echo $PYVENV_MGR_VERSION;;
    "create")
      shift
      create $@;;
    "activate")
      shift
      activate $@;;
  esac
}

manager $@
