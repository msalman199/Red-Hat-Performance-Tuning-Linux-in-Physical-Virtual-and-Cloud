#!/bin/bash
echo "Monitoring Kubernetes pod performance..."
echo "Timestamp,Pod,CPU,Memory" > k8s_performance.csv
for i in {1..10}; do
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    kubectl top pods -n performance-lab --no-headers | while read line; do
        echo "$timestamp,$line" >> k8s_performance.csv
    done
    sleep 30
done
