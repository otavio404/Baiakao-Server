#!/bin/bash
while true; do
  ./otx > data/logs/output.log &
  PID=$!
  echo $PID > theotxcombat.pid
  wait $PID
  sleep 5
done