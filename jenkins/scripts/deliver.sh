#!/bin/bash
npm run build
echo "Starting server..."
serve -s build -l 3000 2>&1 | tee /var/jenkins_home/server.log  # Logs output
# Or: nohup serve -s build -l 3000 > /var/jenkins_home/server.log 2>&1 &
