command -v rbenv >/dev/null || return

export RBENV_ROOT="$HOME/.local/share/rbenv"
export PATH="$RBENV_ROOT/shims:${PATH}"
export RBENV_SHELL=zsh

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
