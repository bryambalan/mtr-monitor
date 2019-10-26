#!/bin/bash

# number of pings sent
CYCLES=15
# inverval between MTR tests in seconds
INTERVAL=20
MTR_HOSTS=("8.8.8.8" "reddit.com" "facebook.com" "robson.com" "github.com")
# Conexao banco
INFLUXDB_HOST="localhost"
INFLUXDB_PORT=8086

function monitor_mtr() {
  for MTR_HOST in "${MTR_HOSTS[@]}"; do
    ( mtr -z -n --report --json --report-cycles $CYCLES $MTR_HOST | /opt/mtr-monitor/save_data.py --host $INFLUXDB_HOST --port $INFLUXDB_PORT ) &
  done
}

which mtr &>/dev/null
if [ $? -eq 1 ]; then
  echo "mtr is not available on this system - it is required for this script to work"
  exit 1
fi

while true; do
  monitor_mtr
  sleep $INTERVAL
done







