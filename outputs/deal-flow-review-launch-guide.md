# Deal Flow Review — Launch Guide

**Date:** 2026-02-19

This guide gets your deal flow pipeline running. Work through the setup steps once, then the pipeline runs automatically every other evening.

---

## A. What Was Built

| Artifact | What it does | Location |
|---|---|---|
| `CLAUDE.md` | Tells Claude Code how this project works, scheduling instructions | `/CLAUDE.md` |
| `deal-flow-orchestrator.md` | Orchestrator agent — scans Drive, coordinates pipeline, posts to Notion, notifies | `.claude/agents/deal-flow-orchestrator.md` |
| `deal-evaluator-agent.md` | Evaluation agent — runs full SKILL.md framework on deal documents | `.claude/agents/deal-evaluator-agent.md` |
| `competitive-researcher-agent.md` | Research agent — competitor pricing + G2/Capterra customer gap analysis | `.claude/agents/competitive-researcher-agent.md` |
| `competitive-researcher/SKILL.md` | Skill: competitor identification and pricing comparison | `skills/competitive-researcher/SKILL.md` |
| `customer-gap-analyzer/SKILL.md` | Skill: G2/Capterra review analysis for customer gaps | `skills/customer-gap-analyzer/SKILL.md` |
| `evaluation-formatter/SKILL.md` | Skill: formats evaluation into Notion page + ntfy notification | `skills/evaluation-formatter/SKILL.md` |
| `config.json` | Runtime config — folder IDs, Notion IDs, ntfy topic | `scripts/config.json` |
| `processed-deals.txt` | State file — tracks evaluated deals to avoid re-runs | `scripts/processed-deals.txt` |
| `deal-flow-review-building-block-spec.md` | Full technical spec for this workflow | `outputs/deal-flow-review-building-block-spec.md` |

---

## B. Setup Steps

Work through these in order. Steps 1–4 have no technical requirements. Steps 5–6 need brief terminal use.

### Step 1: Set up ntfy.sh (5 minutes)

1. On your phone, search for **"ntfy"** in the App Store and install it (it's free)
2. Open the app and tap the **+** button to subscribe to a topic
3. Choose a unique topic name — something like `noosalabs-deals-pascal` (avoid common words, make it personal)
4. Tap Subscribe

That's it. You'll receive notifications on your phone whenever an evaluation completes.

**Update config:** Open `scripts/config.json` and replace `"TODO: Choose a unique topic name"` with your topic name.

---

### Step 2: Create Notion pages (10 minutes)

You need two things in Notion:

**A. Workflow Settings page** (for the pause control):
1. In Notion, create a new page called **"Workflow Settings"** (put it somewhere you can find it, like your workspace root)
2. Add a checkbox property called **"Workflow paused"** — leave it unchecked
3. Copy the page URL — you'll need the page ID (the long string of numbers and letters at the end of the URL)

**B. Deals database** (for evaluation results):
1. In Notion, create a new **Database** called **"Deal Evaluations"**
2. Add these properties:
   - **Status** (Select): options = `Awaiting Review`, `Pursuing`, `Passed`
   - **Score** (Number)
   - **Date** (Date)
   - **Recommendation** (Select): options = `PURSUE`, `PASS`
3. Copy the database URL — you'll need the database ID (long string at the end)

**Update config:** Open `scripts/config.json` and fill in:
- `notion_deals_database_id` — paste the database ID
- `notion_workflow_settings_page_id` — paste the settings page ID

---

### Step 3: Set up Google Drive folder (5 minutes)

1. In Google Drive, create a folder called **"Deal Flow"** (or use an existing one)
2. This is your deal drop zone — you'll create a subfolder here for each new deal
3. Copy the folder ID from the URL (the part after `/folders/` in the URL)

**Update config:** Open `scripts/config.json` and fill in `gdrive_watched_folder_id`.

**Folder structure for each deal:**
```
Deal Flow/
└── [Company Name]/
    ├── questions.docx (or similar — questions/Q&A doc, if you have one)
    ├── PL-[CompanyName].xlsx (P&L)
    ├── SIM-[CompanyName].pdf (or .docx)
    └── [any other materials]
```

The orchestrator reads filenames to determine priority — files with "question", "Q&A", or "founder" in the name are read first.

---

### Step 4: Install mcp-gdrive (15 minutes, one terminal step)

This connects Claude Code to your Google Drive. Ask Claude Code to do this for you:

```
Install the mcp-gdrive MCP server from https://github.com/isaacphi/mcp-gdrive
and configure it in this project. I need Google Drive access for the deal flow pipeline.
```

Claude Code will walk you through the Google OAuth setup (you'll need to log in to your Google account once in a browser).

---

### Step 5: Install Playwright MCP (5 minutes)

This lets the competitive researcher browse websites like G2 and Capterra. Ask Claude Code:

```
Install the Playwright MCP server so the competitive-researcher-agent can browse websites.
```

---

### Step 6: Schedule the orchestrator (2 minutes)

Once the above steps are complete, tell Claude Code:

```
Schedule my deal-flow-orchestrator to run every other day at 8:00 PM.
```

Claude Code creates the launchd schedule automatically. The first time it runs, macOS will show a notification about background activity — this is normal. Keep the toggle ON in System Settings.

---

## C. First Run

Before relying on the schedule, do a manual test run with a real or sample deal.

**Prepare a test deal in Google Drive:**
1. Create a subfolder called `TestDeal` in your Deal Flow folder
2. Drop in any deal documents you have (even a sample P&L and SIM)

**Trigger a manual run:**
```
Run the deal-flow-orchestrator now.
```

**What you should see happen:**
1. Claude Code opens the orchestrator agent
2. It checks your Notion Workflow Settings page (pause check)
3. It scans the Google Drive folder, finds `TestDeal`
4. It dispatches the deal evaluator and competitive researcher in parallel
5. Both agents run (this takes 5–10 minutes)
6. Results are posted to your Notion Deals database
7. You receive a push notification on your phone

**What good output looks like:**
- A new page appears in your Notion Deals database with the company name, PURSUE/PASS verdict, and score
- Your phone shows a notification: `[Company] | PURSUE ✓ | Score: 22/35 | Review: [link]`
- Clicking the Notion link shows the full structured evaluation

**Common first-run issues:**

| Issue | What to do |
|---|---|
| "mcp-gdrive not connected" | Check Step 4 — Google OAuth may need to be re-authenticated |
| Notion page not created | Check that `notion_deals_database_id` in config.json is correct |
| No phone notification | Check ntfy topic name matches in config.json and the app |
| Agent times out | The evaluation is thorough — 10–15 minutes is normal for the first run |
| "Workflow paused" message | Check the Notion Workflow Settings page — the checkbox may be checked |

---

## D. What to Do Next

### Running the pipeline again
Every other evening, it runs automatically. To trigger a manual run anytime:
```
Run the deal-flow-orchestrator now.
```

### Adding a new deal
1. Create a subfolder in your Google Drive Deal Flow folder with the company name
2. Drop in the documents (questions doc first if you have one, P&L, SIM)
3. The next scheduled run (or a manual trigger) will pick it up automatically

### Pausing the pipeline (PTO, busy week)
Open your **Notion Workflow Settings** page and check **"Workflow paused"**. That's it. Uncheck to resume.

### Reviewing an evaluation
When you get a notification, tap the Notion link. The page shows:
- Executive summary and PURSUE/PASS at the top
- Full criteria scores, risk flags, growth opportunities
- Competitive landscape and customer gaps
- Phase 1 questions to send to the seller (if needed)

Your job: read it, decide PURSUE or PASS, update the Status property in Notion.

### When the framework needs updating
After each evaluation, if you spot something the framework missed or got wrong, update `docs/learnings.md` and the relevant SKILL.md. The agents pick up changes automatically on the next run.

### Checking logs
If something goes wrong, ask Claude Code:
```
Show me the logs from the last deal-flow-orchestrator run.
```
Or check `logs/scheduled/` directly for the latest log file.
