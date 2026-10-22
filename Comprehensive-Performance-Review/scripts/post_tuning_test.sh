#!/bin/bash

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
TEST_DIR="/opt/performance-review/post_tuning/${TIMESTAMP}"
mkdir -p "$TEST_DIR"
cd "$TEST_DIR" || exit 1

echo "Post-tuning test starting: $TIMESTAMP"

/opt/performance-review/scripts/generate_load.sh &

DURATION=120
SAMPLE_INTERVAL=2
SAMPLES=$((DURATION / SAMPLE_INTERVAL))

top -b -d "$SAMPLE_INTERVAL" -n "$SAMPLES" > top_output.txt &
TOP_PID=$!
iostat -x "$SAMPLE_INTERVAL" "$SAMPLES" > iostat_output.txt &
IOSTAT_PID=$!

: > memory_tracking.txt
remaining=$DURATION
while [ "$remaining" -gt 0 ]; do
    echo "$(date +%s) $(free -m | awk '/Mem:/ {print $2, $3}')" >> memory_tracking.txt
    sleep "$SAMPLE_INTERVAL"
    remaining=$((remaining - SAMPLE_INTERVAL))
done &
MEM_PID=$!

wait $TOP_PID $IOSTAT_PID $MEM_PID 2>/dev/null

echo "$TEST_DIR" > /opt/performance-review/post_tuning/LATEST
echo "Post-tuning test complete. Data in $TEST_DIR"
