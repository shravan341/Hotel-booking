#!/bin/bash

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BUILD_DIR="${SCRIPT_DIR}/../../build"  # Adjust path as needed based on your actual structure

echo "Building application..."
npm run build

if [ $? -ne 0 ]; then
  echo "Build failed!"
  exit 1
fi

echo "Starting server..."
# Using nohup to run in background and write logs to file
nohup serve -s "$BUILD_DIR" -l 3000 > /var/jenkins_home/server.log 2>&1 &

# Get the PID of the serve process
SERVER_PID=$!
echo "Server started with PID: $SERVER_PID"

# Save the PID to a file so kill.sh can use it
echo "$SERVER_PID" > /var/jenkins_home/serve.pid

echo "Server is running on port 3000"
echo "Logs are being written to /var/jenkins_home/server.log"
