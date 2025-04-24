#!/usr/bin/env sh

npm run build

# Kill any existing app (optional: if you're not using a separate kill.sh)
if [ -f .pidfile ]; then
    kill -9 $(cat .pidfile)
    rm .pidfile
fi

# Serve the production build
npx serve -s build &
sleep 1
echo $! > .pidfile

echo 'Now...'
echo 'Visit http://localhost:5000 to see your deployed React app.'
