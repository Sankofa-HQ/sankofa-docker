#!/bin/sh

# Start the Go engine in the background
./sankofa &

# Start the Next.js dashboard
# Standalone mode expects to be run from the .next/standalone directory
# But we will use the HOST variable to ensure it's accessible
export PORT=3000
node dashboard/server.js
