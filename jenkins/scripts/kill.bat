#!/usr/bin/env sh

if [ -f .pidfile ]; then
  PID=$(cat .pidfile)

  if ps -p $PID > /dev/null 2>&1; then
    echo "Killing process $PID"
    kill -9 $PID
  else
    echo "Process $PID not running."
  fi

  rm .pidfile
else
  echo ".pidfile not found. Nothing to kill."
fi
