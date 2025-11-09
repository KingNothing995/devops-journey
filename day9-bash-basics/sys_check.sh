#!/bin/bash
# This script will be used to check service availability

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

check_service() {
  if pgrep "$1" &>/dev/null; then
    echo -e "${GREEN}$1 is running${NC}"
  else
    echo -e "${RED}$1 is NOT running${NC}"
  fi
}

echo "Checking essential services..."
check_service "nginx"
check_service "ssh"
check_service "cron"

