# Deal Flow Review — AI Building Block Spec

**Version:** 1.0
**Date:** 2026-02-19
**Owner:** Pascal @ Noosa Labs
**Source workflow:** `WORKFLOW_DEFINITION.md` v2.0

---

## Execution Pattern Recommendation

**Pattern:** Multi-Agent
**Interaction Mode:** Hybrid

**Reasoning:**
- Tool use required across multiple systems (Drive, Notion, Granola, web, browser)
- Multiple distinct expertise domains (financial analysis, market research, investment evaluation)
- Parallel execution opportunity (competitive research runs alongside deal evaluation)
- Critical human review gate at PURSUE/PASS decision — human must remain in the loop
- Scheduled unattended execution for most of the pipeline, with human pause at decision point

---

## Architecture Decisions

| Decision | Choice | Rationale |
|---|---|---|
| **Platform** | Claude Code subagent | Full tool access, MCP support, code execution, CLI scheduling |
| **Deployment surface** | CLI (Claude Code) | Terminal-based, supports unattended execution via launchd |
| **Code comfort** | Yes | No no-code constraints; full implementation flexibility |
| **Shareability** | Solo (Pascal only) | No multi-user setup needed |
| **Browser access** | Yes — Playwright MCP | Competitor research (G2, Capterra, pricing pages) requires browser automation |
| **Scheduled execution** | Every other evening via launchd | Claude Code can't self-schedule; launchd plist triggers a shell script that calls `claude` CLI |
| **Pause/resume control** | Notion toggle | Orchestrator checks a "Workflow paused" checkbox on a Notion Settings page at startup; user pauses by checking the box in Notion |
| **Data sensitivity** | None | No compliance requirements |

### Integration Mapping

| Tool | Status | Notes |
|---|---|---|
| **Notion** | ✅ Native/zero-config | Official hosted MCP at `mcp.notion.com` — already active |
| **Granola** | ✅ Native/zero-config | Official Granola MCP — already active |
| **PDFs** | ✅ Native/zero-config | Claude Code reads PDFs natively via `Read` tool |
| **Excel (.xlsx)** | ✅ Native with code execution | Python (openpyxl/pandas) via code execution |
| **Google Drive** | 🔧 MCP (requires setup) | `isaacphi/mcp-gdrive` — Drive search, file read, Sheets read. Needs Google Cloud OAuth + npm build |
| **ntfy.sh** | ✅ Zero-config | Push notification via single `curl` call; no API key needed |
| **Playwright** | 🔧 MCP (requires setup) | Browser automation for G2, Capterra, competitor pricing pages |

### Constraints Summary

- Google Drive MCP requires OAuth credentials setup before autonomous runs can start
- Playwright MCP requires installation before competitive research can run autonomously
- launchd scheduling requires a one-time plist setup on Pascal's Mac
- Notion "Workflow paused" toggle page must be created before first scheduled run

---

## Scenario Summary

| Attribute | Value |
|---|---|
| **Workflow name** | Deal Flow Review |
| **Stages in scope** | Stages 1–5, 9 (Discovery through Decision + Learning) |
| **Out of scope (Phase 1)** | Stages 6–8 (Deep Due Diligence, Investment Memo, Negotiation) |
| **Trigger** | launchd schedule, every other evening |
| **Volume** | 1–2 deals/week currently; framework stable at this volume |
| **Human gates** | One mandatory: PURSUE/PASS decision after evaluation |
| **Output** | Notion page per deal + ntfy.sh push notification |

---

## Step-by-Step Decomposition

| # | Stage | Step | Autonomy | Building Blocks | Tools | Human Gate? |
|---|---|---|---|---|---|---|
| 1 | Startup | Check Notion "Workflow paused" toggle | AI-Deterministic | Orchestrator | Notion MCP | No — exit if paused |
| 2 | Stage 1 | Scan Google Drive watched folder for new deal subfolders | AI-Autonomous | Orchestrator | Google Drive MCP | No |
| 3 | Stage 2 | Inventory documents in each new deal folder; determine reading priority | AI-Autonomous | Orchestrator | Google Drive MCP | No |
| 4 | Stage 2b | Check Granola for meeting notes matching deal name | AI-Autonomous | Orchestrator | Granola MCP | No |
| 5 | Stage 3-0 | P&L Interrogation — flag unclear expenses >$50k, calculate founder comp | AI-Semi-Autonomous | Deal Evaluator + deal-evaluator skill | Code execution (Excel/PDF) | No |
| 6 | Stage 3-A | Criteria Match — score 5 criteria (ARR, Growth, SDE, PLG, SMB) | AI-Deterministic | Deal Evaluator + deal-evaluator skill | — | No |
| 7 | Stage 3-B | Risk Assessment — scan for critical flags | AI-Deterministic | Deal Evaluator + deal-evaluator skill | — | No |
| 8 | Stage 3-C | Growth Opportunities — REAL vs PIE-IN-THE-SKY classification | AI-Semi-Autonomous | Deal Evaluator + deal-evaluator skill | Web search | No |
| 9 | Stage 3-D | Competitive Research — pricing for 3–5 competitors | AI-Semi-Autonomous | Competitive Researcher + competitive-researcher skill | Playwright MCP + Web search | No |
| 10 | Stage 3-D | Customer Gap Analysis — G2/Capterra reviews for all competitors | AI-Semi-Autonomous | Competitive Researcher + customer-gap-analyzer skill | Playwright MCP + Web search | No |
| 11 | Stage 3-E | Customer Economics — flag missing churn/cohort/MRR data | AI-Deterministic | Deal Evaluator + deal-evaluator skill | — | No |
| 12 | Stage 3-F | Stack Ranking — composite score (criteria + growth + risk + price) | AI-Deterministic | Deal Evaluator + deal-evaluator skill | — | No |
| 13 | Stage 4-5a | Format evaluation — build Notion page structure + notification payload | AI-Autonomous | Orchestrator + evaluation-formatter skill | — | No |
| 14 | Stage 4-5b | Post evaluation to Notion database | AI-Autonomous | Orchestrator | Notion MCP | No |
| 15 | Stage 4-5c | Send ntfy.sh push notification with deal name, verdict, score, Notion link | AI-Autonomous | Orchestrator | Bash (curl) | No |
| 16 | Stage 4-5d | **Human review gate** — Pascal reads Notion page, makes PURSUE/PASS call | Human | — | Notion | **YES** |
| 17 | Stage 9 | Update learnings.md / Notion learnings database with patterns identified | AI-Semi-Autonomous | Orchestrator | Notion MCP + file write | Optional |

### Parallelism

Steps 5–12 split into two parallel tracks after document inventory:

```
Orchestrator dispatches:
├── [Track A] Deal Evaluator Agent → Steps 5–8, 11–12
└── [Track B] Competitive Researcher Agent → Steps 9–10
        Results merge at Step 13 (evaluation formatter)
```

---

## Autonomy Spectrum Summary

| Level | Steps | Count |
|---|---|---|
| Human | Stage 4-5d (PURSUE/PASS decision) | 1 |
| AI-Deterministic | Criteria scoring, risk flags, customer economics, stack ranking, pause check | 5 |
| AI-Semi-Autonomous | P&L interrogation, growth classification, competitive research, customer gap analysis | 4 |
| AI-Autonomous | Drive scan, document inventory, Granola check, format, post to Notion, notify | 6 |

---

## Skill Candidates

### Skill 1: deal-evaluator *(exists — SKILL.md v2.0)*

| Attribute | Detail |
|---|---|
| **Purpose** | Run the full systematic evaluation framework (Steps 0–6) on a set of deal documents |
| **Inputs** | Document contents (P&L, SIM, questions doc, website notes); document reading priority order |
| **Outputs** | Structured evaluation: criteria scores, risk flags, growth opportunities (REAL vs PIE-IN-THE-SKY), Phase 1 questions, composite score, PURSUE/PASS recommendation |
| **Decision logic** | P&L interrogation rules; 5-criteria scoring thresholds; critical flag detection; pricing opportunity triggers (>70% organic + last increase >3 yrs = mandatory check); REAL vs speculative classification rules; composite scoring formula |
| **Failure modes** | Missing P&L → flag and halt scoring; no questions doc → proceed with lower confidence note; unclear expenses → generate Phase 1 questions rather than guess; partial Google Doc analysis → use as supplementary context only, never replace framework |

---

### Skill 2: competitive-researcher *(new)*

| Attribute | Detail |
|---|---|
| **Purpose** | Identify 3–5 competitors for a product category and build a pricing comparison table |
| **Inputs** | Company name, product category, business description, target company's current pricing (if known) |
| **Outputs** | Competitor table (name, pricing tiers, key differentiators); pricing gap analysis; flag if competitors are 50%+ more expensive |
| **Decision logic** | Identify direct competitors first, adjacent tools second; flag 50%+ price gap as automatic pricing opportunity signal; distinguish organic/SEO-driven vs. sales-led competitors; note if target appears in competitor positioning |
| **Failure modes** | No clear competitors found → broaden search to adjacent categories and note; paywalled pricing → mark as "pricing not public", use G2/Capterra for signals; JS-heavy pages → use Playwright |

---

### Skill 3: customer-gap-analyzer *(new)*

| Attribute | Detail |
|---|---|
| **Purpose** | Scrape G2 and Capterra reviews for competitors to surface customer complaints, unmet needs, and switching triggers |
| **Inputs** | List of competitor names, product category |
| **Outputs** | Gap table — top 3–5 unmet needs per competitor; recurring complaint themes; features customers say they'd pay more for; any mentions of switching from/to the target company |
| **Decision logic** | Weight gaps by frequency and recency; flag gaps appearing across 2+ competitors as "category-wide opportunity"; distinguish feature gaps (buildable) from workflow gaps (positioning repositioning needed); note target company mentions in competitor reviews |
| **Failure modes** | Few reviews found → note low data confidence; Playwright required for JS-heavy pages; paywalled reviews → skip and note |

---

### Skill 4: evaluation-formatter *(new)*

| Attribute | Detail |
|---|---|
| **Purpose** | Transform completed evaluation + competitive research into a structured Notion page and ntfy.sh notification payload |
| **Inputs** | Evaluation report (scores, flags, opportunities, Phase 1 questions, recommendation), competitive research output, deal name, composite score |
| **Outputs** | Notion page blocks (executive summary, criteria table, risk section, growth section, competitive table, customer gap table, Phase 1 questions); notification message (deal name, PURSUE/PASS, score, Notion URL) |
| **Decision logic** | Format PURSUE evaluations with full detail across all sections; format PASS evaluations with brief rationale only; always surface Phase 1 questions if generated; include customer gap highlights in growth section |
| **Failure modes** | Missing composite score → post with "INCOMPLETE" flag; Notion write fails → save to `outputs/[deal-name]-evaluation.md` as fallback |

---

## Agent Configuration

### Agent 1: deal-flow-orchestrator

| Component | Spec |
|---|---|
| **Name** | `deal-flow-orchestrator` |
| **Description** | Monitors Google Drive for new deal folders on schedule, coordinates the evaluation pipeline, posts results to Notion, and notifies Pascal via ntfy.sh. Invoke on launchd schedule or manually to process pending deals. |
| **Model** | claude-sonnet-4-6 (coordination + light reasoning) |
| **Tools** | Google Drive MCP, Granola MCP, Notion MCP, Bash (curl for ntfy.sh) |

**Instructions:**
Mission: Detect new deal folders in the designated Google Drive folder, coordinate parallel evaluation pipeline, post results to Notion, and notify Pascal.

Startup behavior:
1. Check Notion "Workflow Settings" page for "Workflow paused" checkbox — exit cleanly if checked
2. Read state file (`scripts/processed-deals.txt`) to identify already-processed folders

Pipeline behavior per new deal:
1. Inventory documents in the deal folder; apply document reading priority (questions doc → P&L → SIM → other)
2. Check Granola for meeting notes matching the deal name
3. Dispatch Deal Evaluator agent and Competitive Researcher agent in parallel, passing document contents
4. Await both agents; merge results
5. Run evaluation-formatter skill on merged output
6. Write formatted evaluation to Notion deals database
7. Send ntfy.sh notification: `curl -d "[DEAL NAME] | [PURSUE/PASS] | Score: [X]/35 | [Notion URL]" ntfy.sh/[topic]`
8. Append deal folder ID to `scripts/processed-deals.txt`

Never re-evaluate a deal already in the processed list. If a Google Doc contains partial analysis text, pass it to the Deal Evaluator as supplementary context — never skip the evaluation framework.

---

### Agent 2: deal-evaluator-agent

| Component | Spec |
|---|---|
| **Name** | `deal-evaluator-agent` |
| **Description** | Runs the full systematic evaluation framework on a set of deal documents. Invoke with document contents to receive a structured PURSUE/PASS evaluation with scores, flags, and opportunities. |
| **Model** | claude-sonnet-4-6 (complex reasoning, financial analysis) |
| **Tools** | Code execution (Excel/PDF parsing), Web search (pricing checks for Step 3-C) |

**Instructions:**
Mission: Execute the deal-evaluator skill framework exactly and completely, producing a structured evaluation.

Behavior:
- Read documents in priority order: questions doc first (if present), then P&L, then SIM, then other materials
- Never score criteria without completing P&L interrogation (Step 0) first
- Always distinguish REAL from PIE-IN-THE-SKY opportunities
- For AI displacement risk: assess timeline AND moat, not just presence of risk
- Return structured output including: all step outputs, Phase 1 questions (if any), composite score breakdown, PURSUE/PASS recommendation with conviction level

---

### Agent 3: competitive-researcher-agent

| Component | Spec |
|---|---|
| **Name** | `competitive-researcher-agent` |
| **Description** | Researches 3–5 competitors for a product category, builds pricing comparison, and analyzes G2/Capterra reviews for customer gaps. Runs in parallel with Deal Evaluator. |
| **Model** | claude-sonnet-4-6 (research + synthesis) |
| **Tools** | Web search, Playwright MCP (browser automation) |

**Instructions:**
Mission: Produce a complete competitive landscape — pricing analysis and customer gap analysis — for the acquisition target.

Behavior:
1. Run competitive-researcher skill: identify 3–5 competitors, research pricing
2. Run customer-gap-analyzer skill on G2 and Capterra for all identified competitors — this is mandatory, not optional
3. Flag if target company appears in competitor reviews
4. Flag any competitors 50%+ more expensive than target
5. Return: competitor table, pricing gap analysis, customer gap table

---

### Orchestration Pattern

```
launchd trigger (every other evening)
    └── deal-flow-orchestrator
            ├── [Check 1] Notion "Workflow paused"? → exit if yes
            ├── [Check 2] Read processed-deals.txt
            └── For each new deal folder:
                    ├── Inventory documents + Granola check
                    ├── [Parallel A] deal-evaluator-agent
                    │       └── deal-evaluator skill (Steps 0–6)
                    └── [Parallel B] competitive-researcher-agent
                                ├── competitive-researcher skill
                                └── customer-gap-analyzer skill (G2 + Capterra)
                    │
                    ├── Merge A + B results
                    ├── evaluation-formatter skill
                    ├── Write to Notion
                    └── ntfy.sh notification
                            └── [Human gate: Pascal reviews in Notion → PURSUE/PASS]
```

---

## Step Sequence and Dependencies

```
Step 1 (pause check) → must complete before any other step
Step 2 (Drive scan) → must complete before Step 3
Step 3 (doc inventory) → unlocks parallel dispatch
Steps 5–8, 11–12 [Track A] ← depend on Step 3
Steps 9–10 [Track B] ← depend on Step 3
Step 13 (format) ← depends on both tracks completing
Steps 14–15 (Notion + notify) ← depend on Step 13
Step 16 (human review) ← depends on Step 14
Step 17 (learnings) ← optional, after Step 16
```

---

## Prerequisites

| Prerequisite | Status | Setup needed |
|---|---|---|
| Google Drive MCP (`isaacphi/mcp-gdrive`) | 🔧 Not installed | Google Cloud project, OAuth credentials, npm build |
| Playwright MCP | 🔧 Not installed | MCP server install and configuration |
| Notion MCP | ✅ Active | Already configured |
| Granola MCP | ✅ Active | Already configured |
| Notion "Workflow Settings" page | 🔧 Not created | Create page with "Workflow paused" checkbox |
| Notion deals database | 🔧 Not created | Create database for evaluation results |
| ntfy.sh topic | 🔧 Not created | Choose topic name, install ntfy app on phone |
| `scripts/processed-deals.txt` | 🔧 Not created | Empty file to track processed deal IDs |
| launchd plist | 🔧 Not created | One-time setup on Pascal's Mac |
| Google Drive watched folder | 🔧 Not confirmed | Confirm folder path/ID for deal drop zone |

---

## Context Inventory

| Context Item | Used by | Source |
|---|---|---|
| deal-evaluator skill (SKILL.md v2.0) | Deal Evaluator agent | `skills/deal-evaluator/SKILL.md` |
| competitive-researcher skill | Competitive Researcher agent | To be created |
| customer-gap-analyzer skill | Competitive Researcher agent | To be created |
| evaluation-formatter skill | Orchestrator | To be created |
| Google Drive watched folder ID | Orchestrator | Config file |
| Notion deals database ID | Orchestrator | Config file |
| Notion Workflow Settings page ID | Orchestrator | Config file |
| ntfy.sh topic name | Orchestrator | Config file |
| processed-deals.txt path | Orchestrator | `scripts/processed-deals.txt` |

---

## Tools and Connectors Required

| Tool | Type | Agent(s) | Setup |
|---|---|---|---|
| Google Drive MCP | MCP (requires setup) | Orchestrator | Install + OAuth |
| Notion MCP | MCP (active) | Orchestrator | Already done |
| Granola MCP | MCP (active) | Orchestrator | Already done |
| Playwright MCP | MCP (requires setup) | Competitive Researcher | Install |
| Web search | Built-in | Deal Evaluator, Competitive Researcher | Already available |
| Code execution | Built-in | Deal Evaluator | Already available |
| Bash / curl | Built-in | Orchestrator (ntfy.sh) | Already available |
| ntfy.sh | HTTP service | Orchestrator | No setup (just pick topic name) |
| launchd | macOS scheduler | — | One-time plist setup |

---

## Recommended Implementation Order

**Phase 1 — Quick wins (no MCP setup needed):**
1. Create the three new skills (competitive-researcher, customer-gap-analyzer, evaluation-formatter)
2. Create Notion databases (Workflow Settings page + Deals database)
3. Set up ntfy.sh (choose topic, install app on phone)
4. Create `scripts/processed-deals.txt` and `scripts/config.json`
5. Build and test deal-evaluator-agent manually (invoke from CLI with sample documents)

**Phase 2 — MCP setup:**
6. Install and configure `isaacphi/mcp-gdrive` with Google OAuth
7. Install Playwright MCP
8. Test competitive-researcher-agent end-to-end with a sample deal

**Phase 3 — Orchestration:**
9. Build deal-flow-orchestrator agent
10. Test full pipeline manually (all agents, Notion write, ntfy.sh notification)
11. Set up launchd plist for scheduled execution
12. Run first scheduled end-to-end test

---

## Where to Run

**All agents:** Claude Code CLI on Pascal's Mac
**Scheduler:** macOS launchd (plist in `~/Library/LaunchAgents/`)
**Pause control:** Notion "Workflow Settings" page checkbox
**Deal input:** Google Drive watched folder (one subfolder per deal)
**Output:** Notion deals database page per deal + ntfy.sh push notification
