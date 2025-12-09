#!/bin/sh

set -euCo pipefail

# declare -r LOCK="i3lockr --blur 50 && sleep 1"
declare -r LOCK="loginctl lock-session $XDG_SESSION_ID && sleep 1"
declare -Ar menu=(
  ["Display Off"]="xset dpms force off"
  ["Lock"]="$LOCK"
  ["Logout"]="i3-msg exit"
  ["Suspend"]="$LOCK && systemctl suspend"
  ["Hibernate"]="$LOCK && systemctl hibernate"
  ["Reboot"]="systemctl reboot"
  ["Shutdown"]="systemctl poweroff"
)

function print_keys() {
  local -r IFS=$'\n'
  echo "${!menu[*]}"
}

function main() {
  local -r yes='yes' no='no'

  if [[ $# -eq 0 ]]; then
    print_keys
  elif [[ $# -eq 1 ]]; then
    echo $1 ${no}
    echo $1 ${yes}
  elif [[ $2 == ${yes} ]]; then
    eval "${menu[$1]}"
  elif [[ $2 == ${no} ]]; then
    print_keys
  fi
}

main $@
