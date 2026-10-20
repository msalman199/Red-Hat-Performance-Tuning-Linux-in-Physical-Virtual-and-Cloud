#!/bin/bash

TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')
PROFILE_NAME=$1
OUTPUT_DIR="~/tuned_performance_data"

# Create output directory if it doesn't exist
mkdir -p $OUTPUT_DIR

echo "=== Performance Monitoring for Profile: $PROFILE_NAME ===" > $OUTPUT_DIR/${PROFILE_NAME}_${TIMESTAMP}.log
echo "Timestamp: $(date)" >> $OUTPUT_DIR/${PROFILE_NAME}_${TIMESTAMP}.log
echo "" >> $OUTPUT_DIR/${PROFILE_NAME}_${TIMESTAMP}.log

# System information
echo "=== System Information ===" >> $OUTPUT_DIR/${PROFILE_NAME}_${TIMESTAMP}.log
uname -a >> $OUTPUT_DIR/${PROFILE_NAME}_${TIMESTAMP}.log
echo "" >> $OUTPUT_DIR/${PROFILE_NAME}_${TIMESTAMP}.log

# CPU information
echo "=== CPU Information ===" >> $OUTPUT_DIR/${PROFILE_NAME}_${TIMESTAMP}.log
lscpu >> $OUTPUT_DIR/${PROFILE_NAME}_${TIMESTAMP}.log
echo "" >> $OUTPUT_DIR/${PROFILE_NAME}_${TIMESTAMP}.log

# Current tuned profile
echo "=== Current Tuned Profile ===" >> $OUTPUT_DIR/${PROFILE_NAME}_${TIMESTAMP}.log
tuned-adm active >> $OUTPUT_DIR/${PROFILE_NAME}_${TIMESTAMP}.log
echo "" >> $OUTPUT_DIR/${PROFILE_NAME}_${TIMESTAMP}.log

# CPU governor
echo "=== CPU Governor ===" >> $OUTPUT_DIR/${PROFILE_NAME}_${TIMESTAMP}.log
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor >> $OUTPUT_DIR/${PROFILE_NAME}_${TIMESTAMP}.log
echo "" >> $OUTPUT_DIR/${PROFILE_NAME}_${TIMESTAMP}.log

# I/O scheduler
echo "=== I/O Scheduler ===" >> $OUTPUT_DIR/${PROFILE_NAME}_${TIMESTAMP}.log
cat /sys/block/sda/queue/scheduler >> $OUTPUT_DIR/${PROFILE_NAME}_${TIMESTAMP}.log
echo "" >> $OUTPUT_DIR/${PROFILE_NAME}_${TIMESTAMP}.log

# Key kernel parameters
echo "=== Key Kernel Parameters ===" >> $OUTPUT_DIR/${PROFILE_NAME}_${TIMESTAMP}.log
echo "vm.swappiness: $(sysctl -n vm.swappiness)" >> $OUTPUT_DIR/${PROFILE_NAME}_${TIMESTAMP}.log
echo "kernel.sched_min_granularity_ns: $(sysctl -n kernel.sched_min_granularity_ns)" >> $OUTPUT_DIR/${PROFILE_NAME}_${TIMESTAMP}.log
echo "net.core.rmem_max: $(sysctl -n net.core.rmem_max)" >> $OUTPUT_DIR/${PROFILE_NAME}_${TIMESTAMP}.log
echo "" >> $OUTPUT_DIR/${PROFILE_NAME}_${TIMESTAMP}.log

# Memory information
echo "=== Memory Information ===" >> $OUTPUT_DIR/${PROFILE_NAME}_${TIMESTAMP}.log
free -h >> $OUTPUT_DIR/${PROFILE_NAME}_${TIMESTAMP}.log
echo "" >> $OUTPUT_DIR/${PROFILE_NAME}_${TIMESTAMP}.log

# Load average
echo "=== Load Average ===" >> $OUTPUT_DIR/${PROFILE_NAME}_${TIMESTAMP}.log
uptime >> $OUTPUT_DIR/${PROFILE_NAME}_${TIMESTAMP}.log
echo "" >> $OUTPUT_DIR/${PROFILE_NAME}_${TIMESTAMP}.log

echo "Performance data collected in: $OUTPUT_DIR/${PROFILE_NAME}_${TIMESTAMP}.log"
