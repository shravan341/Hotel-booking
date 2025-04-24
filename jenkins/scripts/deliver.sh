#!/usr/bin/env sh

# Kill old process if needed
if [ -f .pidfile ]; then
  PID=$(cat .pidfile)
  if ps -p $PID > /dev/null 2>&1; then
    echo "Killing previous process $PID"
    kill -9 $PID
  fi
  rm .pidfile
fi

# Install serve if not installed
if ! command -v serve >/dev/null 2>&1; then
  npm install -g serve
fi

# Build the app
npm install
npm run build || exit 1

# Start the production server
echo "Starting production server..."
npx serve -s build -l 3000 > serve.log 2>&1 &
echo $! > .pidfile

echo '✅ App running on http://localhost:3000'
