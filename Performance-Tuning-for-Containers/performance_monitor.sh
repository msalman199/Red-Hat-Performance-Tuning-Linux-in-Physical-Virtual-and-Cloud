#!/bin/bash

NAMESPACE="performance-lab"
DURATION=300  # 5 minutes
INTERVAL=10   # 10 seconds

echo "Starting performance monitoring for $DURATION seconds..."
echo "Timestamp,Node_CPU,Node_Memory,Pod_Count,Avg_Pod_CPU,Avg_Pod_Memory" > performance_report.csv

start_time=$(date +%s)
end_time=$((start_time + DURATION))

while [ $(date +%s) -lt $end_time ]; do
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    # Get node metrics
    node_metrics=$(kubectl top nodes --no-headers | awk '{print $2","$4}')
    
    # Get pod count
    pod_count=$(kubectl get pods -n $NAMESPACE --no-headers | wc -l)
    
    # Get average pod metrics
    pod_metrics=$(kubectl top pods -n $NAMESPACE --no-headers | awk '{cpu+=$2; mem+=$3; count++} END {if(count>0) print cpu/count","mem/count; else print "0,0"}')
    
    echo "$timestamp,$node_metrics,$pod_count,$pod_metrics" >> performance_report.csv
    
    sleep $INTERVAL
done

echo "Performance monitoring completed. Report saved to performance_report.csv"
