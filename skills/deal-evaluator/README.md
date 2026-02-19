# Deal Evaluator Skill

Systematic evaluation framework for micro-SaaS acquisition opportunities.

## Purpose

Evaluates deals against Pascal's investment criteria to produce PURSUE/PASS recommendations with supporting analysis, stack ranking, and phase-specific questions.

## Core Evaluation Framework

### Part A: Criteria Match (5-point checklist)
1. ARR >$200k (SDE <$700k for affordability)
2. Growth >10% YoY (or explainable decline)
3. SDE >50% (or achievable)
4. Product-led growth model
5. Sells primarily to SMBs

**Decision:** 
- 5/5 or 4/5: Strong candidate
- 3/5: Borderline (needs strong opportunities)
- <3/5: AUTO-PASS

### Part B: Risk Flags
- Platform dependencies (Meta, LinkedIn) → CRITICAL
- Customer concentration >30% → HIGH
- Founder dependency → MEDIUM
- AI displacement risk → Context-dependent
- Negative cash flow timing → HIGH

### Part C: Growth Opportunities

**Systematic Pricing Check (Always First):**
- When was last price increase?
- Research competitor pricing (mandatory)
- Calculate opportunity if 30%+ underpriced

**REAL Opportunities (Proven Demand):**
- Competitor validation (others doing it successfully)
- Clear underpricing (validated via competitive research)
- Untapped owned distribution (email lists, in-product virality)
- ATS/ecosystem partnerships

**PIE-IN-THE-SKY (Speculative):**
- "Never tried marketing"
- "Could build sales team"
- Hypothetical new products
- AI unlocks (without specific use cases)

### Part D: Competitive Research (MANDATORY)
- Identify 3-5 competitors
- Research pricing
- Assess positioning and market opportunity

### Part E: Customer Economics
Check for missing data (churn, cohorts, MRR trends). Generate Phase 1 questions if absent.

## Key Innovations (v2.0)

### 1. P&L Interrogation (Step 0)
Flag unclear expenses >$50k BEFORE scoring:
- "Outside Services," "Consulting," "Outsourcing"
- Can swing SDE from 35% → 55%
- Generate Phase 1 email questions immediately

**Example:** SurveyPlanet $234k "Outside Services" was CEO payment

### 2. Systematic Pricing Check
Automatic triggers for pricing investigation:
- Last increase >3 years → Strong signal
- Customer complaints <5% → Pricing power
- Organic traffic >70% → Price-insensitive

Research competitor pricing (mandatory), calculate impact.

**Example:** SurveyPlanet 45-95% underpriced vs. market = +$252k ARR opportunity

### 3. Context-Based Growth Assessment
Distinguish structural decline from underexecution:
- Structural (FAIL): Market shrinking, tech obsolescence
- Underexecution (OPPORTUNITY): Never raised prices, never activated channels

**Example:** -8% YoY + never raised prices + never emailed users = FIXABLE

### 4. Document Reading Priority
Read questions doc FIRST (if exists) - contains critical data that changes evaluations (MRR trends, churn, cohorts, opportunities).

### 5. Customer Economics Validation
Flag missing data and generate Phase 1 questions:
- Churn rate (monthly/annual)
- Cohort retention (12-month)
- MRR trend (last 12 months)
- New customers per month

## Usage

### In Claude.ai Chat
1. Upload deal documents (SIM, P&L, questions doc if available)
2. "Evaluate [company name] using the deal-evaluator skill"
3. Claude produces comprehensive evaluation report
4. Discuss findings interactively
5. If PURSUE → generate Phase 2 questions or memo

### In Claude.ai Project (Recommended)
1. Create "Deal Flow" project
2. Add this SKILL.md as project knowledge
3. Upload deal docs to project
4. Simply say: "Evaluate [company name]"
5. Skill auto-invokes

## Output Format

```markdown
# Deal Evaluation: [Company Name]

## Executive Summary
[PURSUE/PASS with 2-3 sentence rationale]

## P&L CLARIFICATION NEEDED
[Unclear expenses requiring Phase 1 questions]

## MISSING CRITICAL DATA
[Customer economics data to request]

## PART A: Criteria Match
[5 criteria scored with rationale]

## PART B: Risk Assessment
[Critical/High/Medium risks identified]

## PART C: Growth Opportunities
[REAL opportunities with evidence, PIE-IN-THE-SKY separately]

## PART D: Competitive Landscape
[3-5 competitors with pricing, positioning]

## PART E: Customer Economics
[Analysis or missing data flags]

## Stack Ranking Score
[Composite score: X/25 or X/35]

## Recommendation
[PURSUE/PASS with next steps]
```

## Stack Ranking Methodology

- Criteria Match: 0-5 points
- Growth Opportunities: 0-10 points (count REAL opps)
- Risk Profile: 0-10 points (start at 10, deduct for risks)
- Price Multiple: 0-10 points (if asking price provided)

**Composite Score:** Sum / 25 (or 35 if price known) = %

## Version History

**v2.0** (2026-02-13): Major update based on SurveyPlanet evaluation
- Added P&L interrogation (Step 0)
- Systematic pricing opportunity checks
- Context-based growth assessment
- Document reading priority
- Customer economics validation
- Enhanced SDE achievability framework
- Clarified ARR vs. affordability

**v1.0**: Initial framework based on Evalart acquisition

## Known Limitations

1. **AI Displacement Risk:** Binary flag, needs multi-factor scoring
2. **Churn Thresholds:** No category-specific benchmarks
3. **Team Transition:** Limited heuristics for founder knowledge transfer
4. **Price Increase Modeling:** Assumes 5% churn, needs cohort-based modeling

See [docs/learnings.md](../../docs/learnings.md) for improvement roadmap.

## Examples

- [Evalart](../../examples/evalart/) - Passed all criteria, strong LatAm positioning
- [SurveyPlanet](../../examples/surveyplanet/) - Failed initially, PURSUE after deep-dive

## Related

- [Future Architecture](../../docs/future-architecture.md) - Sub-agent evolution plan
- [Learnings](../../docs/learnings.md) - Accumulated insights from evaluations
