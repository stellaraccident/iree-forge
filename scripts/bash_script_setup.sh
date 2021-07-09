set -eu -o errtrace
shopt -s inherit_errexit
trap print_backtrace ERR

function print_backtrace () {
  rc=$?
  trap - ERR
  echo "error: unhandled return code $rc" 1>&2
  local deptn=${#FUNCNAME[@]}
  for ((i=1; i<$deptn; i++)); do
    local func="${FUNCNAME[$i]}"
    local line="${BASH_LINENO[$((i-1))]}"
    local src="${BASH_SOURCE[$((i-1))]}"
    printf '%*s' $i '' 1>&2 # indent
    echo "at: $func(), $src, line $line" 1>&2
  done
  die
}

function die() {
  echo "$*" 1>&2
  kill -INT $$
}
