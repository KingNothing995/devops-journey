#!/bin/bash

#=========================================
#Service Checker Script
#=========================================  
#Usage: ./service-check.sh nginx
#Works without systemd (for WSL2)
#=========================================

Service=$1
LOGFILE="service-status.log"   
DATE=$(date '+%Y-%m-%d %H:%M:%S')

if [ -z "$Service" ]; then
    echo "Usage: $0 <service-name>"
    exit 1
fi

# Check if the service is running
if ps aux | grep -v grep | grep -q "$Service"; then
    echo "$DATE - $SERVICE is running." | tee -a $LOGFILE
else
    echo "$DATE - $SERVICE is NOT running. Attempting to restart..." | tee -a $LOGFILE
    sudo /etc/init.d/$Service start
    sleep 2
    if ps aux | grep -v grep | grep -q "$Service"; then
        echo "$DATE - $SERVICE started successfully." | tee -a $LOGFILE
    else
        echo "$DATE - Failed to restart $SERVICE." | tee -a $LOGFILE
    fi
fi