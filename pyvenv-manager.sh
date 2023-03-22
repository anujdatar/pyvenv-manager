#! /bin/bash

windows() { [ -n "$WINDIR" ]; }

create() {

  if [ "$1" ]; then
    target_dir="$1"
  else
    target_dir="$(basename pwd)"
  fi
  python3 -m venv "$HOME/.pyvenvs/$1"
}

venv_detect() {
  if [ "$1" ]; then
    env_dir="$HOME/.pyvenvs/$1"
  else
    env_dir="$(pwd)/venv"
  fi

  if [ -f "$env_dir/bin/python" ]; then
    echo "Python virtual environment available at $env_dir"
  else
    echo "No Python virtual environment available at $env_dir"
    exit 1
  fi
}

activate() {
  if [ "$1" ]; then
    if windows; then
      . $/Scripts/activate
    else
      . $1/bin/activate
    fi
  else
    echo "Python virtual environment not provided"
    exit 1
  fi
}

manager() {
  case $1 in
    "activate")

}
