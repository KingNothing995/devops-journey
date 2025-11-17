#!/bin/bash
# is_even.sh - check if a given integer is even or odd
# Usage: ./is_even.sh 42
# Or: source this file and call is_even 42

is_even() {
  local num="$1"

  # Validate input: must be a (possibly negative) integer
  if ! [[ "$num" =~ ^-?[0-9]+$ ]]; then
    echo "Error: '$num' is not an integer."
    return 2   # non-zero return code indicates error
  fi

  # Use arithmetic modulo to check evenness
  if (( num % 2 == 0 )); then
    echo "Even"
    return 0
  else
    echo "Odd"
    return 1
  fi
}

# If script is called directly, run with first CLI argument
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  if [ $# -lt 1 ]; then
    echo "Usage: $0 <integer>"
    exit 2
  fi
  is_even "$1"
  exit $?
fi
