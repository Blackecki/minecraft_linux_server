#!/bin/bash

# Minecraft Paper Server Start Script

JAR="paper-26.2-111.jar"

# RAM
MIN_RAM="2G"
MAX_RAM="6G"

# Restart delay
RESTART_DELAY=10

echo "Starting Paper Minecraft Server..."
echo "Jar: $JAR"
echo "RAM: $MIN_RAM - $MAX_RAM"

while true
do

java \
-Xms$MIN_RAM \
-Xmx$MAX_RAM \
-XX:+UseG1GC \
-XX:+ParallelRefProcEnabled \
-XX:MaxGCPauseMillis=200 \
-XX:+UnlockExperimentalVMOptions \
-XX:+DisableExplicitGC \
-XX:+AlwaysPreTouch \
-XX:G1NewSizePercent=30 \
-XX:G1MaxNewSizePercent=40 \
-XX:G1HeapRegionSize=8M \
-XX:G1ReservePercent=20 \
-XX:G1HeapWastePercent=5 \
-XX:G1MixedGCCountTarget=4 \
-XX:InitiatingHeapOccupancyPercent=15 \
-XX:G1MixedGCLiveThresholdPercent=90 \
-XX:G1RSetUpdatingPauseTimePercent=5 \
-XX:SurvivorRatio=32 \
-XX:+PerfDisableSharedMem \
-jar $JAR nogui


echo "Server stopped."

echo "Restarting in $RESTART_DELAY seconds..."
sleep $RESTART_DELAY

done
