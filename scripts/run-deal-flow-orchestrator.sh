#!/bin/bash
# Deal Flow Orchestrator — scheduled runner
# Runs every other evening via launchd. Skips on odd days to achieve "every other day" cadence.

PROJECT_DIR="/Users/plg/projects/deal-flow-review"
CLAUDE_BIN="/Users/plg/.local/bin/claude"
LOG_DIR="$PROJECT_DIR/logs/scheduled"
LOG_FILE="$LOG_DIR/orchestrator-$(date +%Y-%m-%d).log"

mkdir -p "$LOG_DIR"

# Every-other-day check: skip if day-of-year is odd
DAY_OF_YEAR=$(date +%j)
if (( DAY_OF_YEAR % 2 != 0 )); then
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] Skipping — not a scheduled run day (day $DAY_OF_YEAR)" >> "$LOG_FILE"
  exit 0
fi

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Starting deal-flow-orchestrator" >> "$LOG_FILE"

cd "$PROJECT_DIR"
"$CLAUDE_BIN" -p "Run the deal-flow-orchestrator agent now." \
  --dangerously-skip-permissions \
  >> "$LOG_FILE" 2>&1

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Finished" >> "$LOG_FILE"
