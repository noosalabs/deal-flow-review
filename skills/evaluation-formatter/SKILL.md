# Evaluation Formatter Skill

**Version:** 1.2
**Last Updated:** 2026-02-20

## Purpose

Transform a completed deal evaluation and competitive research output into a structured entry in the "Live NL Deal Flow" Notion database — with full evaluation reasoning in the page body and Google Drive documents linked exactly as in existing deal pages.

## Database: Live NL Deal Flow

**Database ID:** `abf8b4d135e4480ab34cabb094d4b6a2`

### Properties to populate

| Property | Type | What to fill |
|---|---|---|
| **Name** | title | Company name |
| **Status** | select | Always `Investigation` — never change to Passed, never auto-close |
| **Recommendation** | multi_select | `Pursue` or `Pass` (exact case) |
| **Score** | number | Composite score as integer (e.g. 22) — out of 35 |
| **Priority** | select | `High` if score ≥25, `Medium` if 18–24, `Low` if <18 |
| **MRR** | number | Monthly recurring revenue in dollars (e.g. 60000 for $60k MRR) |
| **Expected EV** | number | Estimated enterprise value = SDE × multiple (use 3–4× for SaaS) |
| **One liner** | text | One sentence describing what the product does |
| **Deal Source** | multi_select | From documents: `Acquire.com`, `Flippa`, `FE International`, `Axial`, `Referral`, `Inbound`, `Outbound`, `SaaS Friends`, `Other broker`, `Pocket Fund` |
| **Contact Name** | text | Founder/seller name if found in documents |
| **Email** | email | Seller email if found |

**Critical rule: Never set Status to "Passed" or any other terminal state.** All deals — whether PURSUE or PASS — are created with Status = `Investigation`. Pascal reviews and updates Status manually. The Recommendation field shows the agent's verdict.

---

## Page Body Structure

The page body follows the pattern of existing deal pages. It has two sections:

### Section 1: Document Links

List every source document from the Google Drive deal folder as a link, using descriptive names matching what they are. Model on the existing "Viewed Video" page pattern:

```
[Q&A with Founder](https://drive.google.com/...)
[P&L - CompanyName](https://drive.google.com/...)
[SIM - CompanyName](https://drive.google.com/...)
[Data Room Folder](https://drive.google.com/...)
[Granola: Founder Call Notes](granola://...) ← if Granola notes exist
```

Use the actual Google Drive file URLs from the deal folder. List the questions/Q&A doc first (consistent with document reading priority). If a Google Drive folder URL is available, include it as "Data Room Folder".

### Section 2: Evaluation Report

Full evaluation content, structured with headings:

```markdown
## [COMPANY NAME] — [PURSUE / PASS] | Score: [X]/35

### Executive Summary
[2–3 sentences: what the business is, why PURSUE or PASS, single most important factor]

---

### Criteria Scores
| Criterion | Result | Notes |
|---|---|---|
| ARR >$200k, SDE <$700k | ✅ Pass / ❌ Fail | [key numbers] |
| Growth >10% YoY | ✅ Pass / ❌ Fail | [rate + context] |
| SDE >50% (or achievable) | ✅ Pass / ❌ Fail | [stated vs. adjusted] |
| Product-led growth, self-serve | ✅ Pass / ❌ Fail | [evidence] |
| SMB-focused | ✅ Pass / ❌ Fail | [evidence] |

**Criteria: [X]/5**

---

### Risk Flags
**Critical** (any = PASS): [none / list]
**High:** [list with evidence]
**Medium:** [list with evidence]

---

### Growth Opportunities

**REAL Opportunities** (proven demand, counted in score)
- [Opportunity]: [Evidence]. Estimated impact: +$[X]k ARR
...

**PIE-IN-THE-SKY** (speculative, not counted)
- [Opportunity]: [Why speculative]
...

---

### Competitive Landscape
| Competitor | Entry price | Pro price | Key differentiator |
|---|---|---|---|
| [Name] | $X/mo | $X/mo | [1 sentence] |

**Pricing gap:** [Target sits at $X vs. market range $Y–$Z]
**Pricing opportunity:** [Yes/No — evidence]

### Customer Gaps (G2 / Capterra)
| Gap | Type | Frequency | Competitors affected |
|---|---|---|---|
| [Gap] | Feature/Workflow/Pricing/Support | High/Med/Low | [names] |

**Category-wide opportunities:** [gaps across 2+ competitors]
**Target mentioned in competitor reviews:** [yes/no + details]

---

### Customer Economics
[What churn/cohort/MRR data exists, what's missing]

---

### Phase 1 Questions
[Only if generated — numbered list of P&L clarifications and data requests]
[Omit this section entirely if no questions were generated]

---

### Score Breakdown
| Component | Score |
|---|---|
| Criteria match | X/5 |
| Growth opportunities | X/10 |
| Risk assessment | X/10 |
| Pricing opportunity | X/10 |
| **Total** | **X/35** |
```

---

## ntfy.sh Notification Payload

Send after the Notion page is created:

```
curl -d "[COMPANY NAME] | [PURSUE ✓ / PASS ✗] | Score: [X]/35 | [Notion page URL]" ntfy.sh/NL-deals-pascal
```

For PURSUE deals, append the top opportunity on a second line using ntfy's title parameter:
```
curl \
  -H "Title: [COMPANY NAME] — PURSUE" \
  -d "Score: [X]/35 | Top: [top REAL opportunity in 1 sentence] | [Notion URL]" \
  ntfy.sh/NL-deals-pascal
```

---

## Failure Modes

| Situation | Response |
|---|---|
| Composite score missing | Set Score field to 0, add "INCOMPLETE EVALUATION" at top of page body |
| Competitive research unavailable | Add "⚠️ Competitive research pending" note in Competitive Landscape section |
| Google Drive file URLs unavailable | Link the folder URL only; note individual files not directly linkable |
| Notion page creation fails | Save full evaluation to `outputs/[company-name]-[YYYY-MM-DD]-evaluation.md`, send ntfy with file path instead of Notion URL |
| ntfy.sh unreachable | Log error — Notion page is the source of truth |
