#!/bin/bash
# backup_status.sh
# This is a script meant to check the staus ofg backups and print them in colors 
#Usage ./backup_status.sh [config]
# If no config provided, script will use ./backup.conf

#-----------CFG-----------------
CONFIG_FILE="${1:-./backup.conf}"

#log file (local to current dir, no sudo needed)
LOG_FILE="./backup_status.log"

#color codes
GREEN='\033[O:32m'   #GREEN TXT
RED='\033[O:31m'     #RED TXT
NC='\033[0m'          #No Color 
YELLOW='\033[O:33m'  #YELLOW TXT

#-----------Assistance-----------------
timestamp() {
#return currend date/time in ISO format
    date +"%Y-%m-%d %T"
}

log() {
    #append a message with timestamp to the log file
    #usage: log "random message"
    echo "$(timestamp) - $1" >> "$LOG_FILE"
}

print_ok() {
  # Print green message to terminal and log it
  echo -e "${GREEN}$1${NC}"
  log "$1"
}

print_warn() {
  # Print yellow message to terminal and log it
  echo -e "${YELLOW}$1${NC}"
  log "$1"
}

print_err() {
  # Print red message to terminal and log it
  echo -e "${RED}$1${NC}"
  log "$1"
}

# --------- Input validation ----------
if [ ! -f "$CONFIG_FILE" ]; then
  print_err "Config file not found: $CONFIG_FILE"
  echo "Create a config file with one directory path per line."
  exit 2  # exit with non-zero code to indicate error
fi

# Start run
log "=== backup_status.sh started using config: $CONFIG_FILE ==="

# --------- Main processing loop ----------
# We use 'while IFS= read -r line' to safely read lines with spaces
while IFS= read -r DIR || [ -n "$DIR" ]; do
  # Skip empty lines and lines starting with '#'
  [[ -z "$DIR" || "$DIR" =~ ^# ]] && continue

  # Expand tilde (~) to home directory if present
  DIR_EXPANDED="${DIR/#\~/$HOME}"

  if [ -d "$DIR_EXPANDED" ]; then
    # directory exists
    print_ok "OK: Directory exists -> $DIR_EXPANDED"
  else
    # directory missing
    print_err "MISSING: Directory not found -> $DIR_EXPANDED"
  fi
done < "$CONFIG_FILE"

log "=== backup_status.sh finished ==="
exit 0