#!/bin/bash

REPORT_DIR="/opt/performance-review/reports"
LATEST_ANALYSIS=$(ls -1t "$REPORT_DIR"/performance_analysis_*.txt 2>/dev/null | head -1)
LATEST_COMPARISON=$(ls -1t "$REPORT_DIR"/performance_comparison_*.txt 2>/dev/null | head -1)
FINAL_REPORT="$REPORT_DIR/FINAL_SUMMARY_$(date +%Y%m%d_%H%M%S).txt"

if [ -z "$LATEST_ANALYSIS" ] || [ -z "$LATEST_COMPARISON" ]; then
    echo "Error: run analyze_performance.sh and compare_performance.sh first."
    exit 1
fi

{
echo "LAB 20 FINAL PERFORMANCE REVIEW SUMMARY"
echo "========================================"
echo "Generated: $(date)"
echo ""
echo "----- BASELINE ANALYSIS -----"
cat "$LATEST_ANALYSIS"
echo ""
echo "----- BEFORE/AFTER COMPARISON -----"
cat "$LATEST_COMPARISON"
echo ""
echo "----- STUDENT WRITTEN INTERPRETATION -----"
echo "(Edit this file manually to add: which resource was the primary"
echo "bottleneck, which tuning parameter most likely explains the observed"
echo "delta, and one additional tunable you would test next.)"
} > "$FINAL_REPORT"

echo "Final summary written to: $FINAL_REPORT"
