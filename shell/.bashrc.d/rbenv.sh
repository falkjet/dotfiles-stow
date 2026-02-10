command -v rbenv >/dev/null || exit

export RBENV_ROOT="$HOME/.local/share/rbenv"
export PATH="$RBENV_ROOT/shims:${PATH}"
export RBENV_SHELL=bash

source '/usr/lib/rbenv/completions/rbenv.bash'
command rbenv rehash 2>/dev/null
rbenv() {
  local command
  command="${1:-}"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  rehash|shell)
    eval "$(rbenv "sh-$command" "$@")";;
  *)
    command rbenv "$command" "$@";;
  esac
}
