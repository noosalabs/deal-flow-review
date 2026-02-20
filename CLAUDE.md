# Deal Flow Review — Claude Code Project

Systematic evaluation framework for micro-SaaS acquisition opportunities at Noosa Labs.

## What This Project Does

This project automates the deal evaluation pipeline:
1. Every other evening, scan a Google Drive folder for new deal subfolders
2. For each new deal, run parallel evaluation (financial analysis + competitive research)
3. Post structured results to a Notion database
4. Send a push notification via ntfy.sh for human review

Pascal makes the final PURSUE/PASS decision in Notion. The agents do everything up to that point.

## Key Files

| File | Purpose |
|---|---|
| `WORKFLOW_DEFINITION.md` | Complete 9-stage workflow definition |
| `skills/deal-evaluator/SKILL.md` | Core evaluation framework (v2.0) — the heart of this system |
| `scripts/config.json` | Runtime configuration (folder IDs, Notion IDs, ntfy topic) |
| `scripts/processed-deals.txt` | State file — deal folder IDs already evaluated |
| `outputs/` | Evaluation outputs and specs |
| `docs/learnings.md` | Accumulated insights from real evaluations |

## Agents

| Agent | File | Role |
|---|---|---|
| `deal-flow-orchestrator` | `.claude/agents/deal-flow-orchestrator.md` | Coordinator — scans Drive, dispatches agents, posts to Notion, notifies |
| `deal-evaluator-agent` | `.claude/agents/deal-evaluator-agent.md` | Financial + investment evaluation using SKILL.md framework |
| `competitive-researcher-agent` | `.claude/agents/competitive-researcher-agent.md` | Competitor pricing + G2/Capterra customer gap analysis |

## Skills

| Skill | File | Used by |
|---|---|---|
| `deal-evaluator` | `skills/deal-evaluator/SKILL.md` | deal-evaluator-agent |
| `competitive-researcher` | `skills/competitive-researcher/SKILL.md` | competitive-researcher-agent |
| `customer-gap-analyzer` | `skills/customer-gap-analyzer/SKILL.md` | competitive-researcher-agent |
| `evaluation-formatter` | `skills/evaluation-formatter/SKILL.md` | deal-flow-orchestrator |

## Configuration

Before the first run, edit `scripts/config.json` with:
- `gdrive_watched_folder_id` — the Google Drive folder ID where deals are dropped
- `notion_deals_database_id` — the Notion database ID for evaluation results
- `notion_workflow_settings_page_id` — the Notion page ID with the "Workflow paused" checkbox
- `ntfy_topic` — your chosen ntfy.sh topic name (pick anything unique)

## Pause / Resume

To pause the pipeline (e.g., while on PTO): open the **Workflow Settings** page in Notion and check the **"Workflow paused"** checkbox. The orchestrator checks this at startup and exits cleanly if paused.

To resume: uncheck it in Notion.

You can also ask Claude Code directly:
- `"Pause the deal-flow-orchestrator"` — disables the scheduled run
- `"Resume the deal-flow-orchestrator"` — re-enables it

## Scheduling Subagents

When setting up scheduled tasks for subagents:
- Use `claude -p "prompt" --dangerously-skip-permissions` to allow headless tool use (required for agents that write files and call MCPs)
- Use the full path to the claude binary (e.g., `~/.local/bin/claude`) since launchd runs with minimal PATH
- Always include logging to capture stdout/stderr for troubleshooting
- Store logs in the project's `logs/scheduled/` folder
- Include timestamps in log filenames for easy debugging

To schedule the orchestrator, tell Claude Code:
```
Schedule my deal-flow-orchestrator to run every other day at 8:00 PM.
```

## Running Manually

To trigger the pipeline immediately:
```
Run the deal-flow-orchestrator now.
```

To evaluate a single deal manually (bypassing Drive scan):
```
Run deal-evaluator-agent on the documents in [path or folder name].
```

## Investment Thesis

- **ARR:** >$200k (SDE must be <$700k for affordability)
- **Growth:** >10% YoY (or explainable decline with recovery path)
- **SDE:** >50% (or achievable through optimization)
- **Business Model:** Product-led growth, self-serve
- **Customer Base:** Primarily SMBs
