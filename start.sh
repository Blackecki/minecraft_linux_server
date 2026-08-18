#!/bin/bash

# Minecraft Paper Server Start Script

JAR="paper-26.2-111.jar"

# RAM
MIN_RAM="2G"
MAX_RAM="6G"

# Restart delay
RESTART_DELAY=10

# Set to true if you want automatic restart after a crash
AUTO_RESTART=true

echo "================================="
echo "      Paper Minecraft Server"
echo "================================="
echo "Jar: $JAR"
echo "RAM: $MIN_RAM - $MAX_RAM"
echo

# Handle Ctrl+C / SIGTERM
shutdown() {
    echo
    echo "Stopping server..."
    AUTO_RESTART=false
}

trap shutdown SIGINT SIGTERM

while true
do
    echo "Starting Paper..."

    java \
        -Xms$MIN_RAM \
        -Xmx$MAX_RAM \
        -XX:+UseG1GC \
        -XX:+ParallelRefProcEnabled \
        -XX:MaxGCPauseMillis=200 \
        -XX:+DisableExplicitGC \
        -XX:+AlwaysPreTouch \
        -XX:+PerfDisableSharedMem \
        -jar "$JAR" nogui

    EXIT_CODE=$?

    echo
    echo "Server stopped with exit code: $EXIT_CODE"

    # Don't restart after Ctrl+C / SIGTERM
    if [ "$AUTO_RESTART" = false ]; then
        echo "Server shutdown requested."
        break
    fi

    echo "Restarting in $RESTART_DELAY seconds..."
    sleep "$RESTART_DELAY"
done

echo "Server process ended."
exit 0
