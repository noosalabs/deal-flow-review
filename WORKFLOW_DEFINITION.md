# Deal Flow Review Workflow Definition

**Version:** 2.0  
**Last Updated:** February 13, 2026  
**Owner:** Pascal @ Noosa Labs

---

## Purpose

Systematize the evaluation of micro-SaaS acquisition opportunities to make consistent, data-driven PURSUE/PASS decisions at scale.

## Investment Thesis

**Target Profile:**
- **ARR:** >$200k (no upper limit)
- **Affordability:** SDE <$700k (sets maximum price we can pay)
- **Growth:** >10% YoY (or explainable decline with clear recovery path)
- **SDE Margin:** >50% (or achievable through team restructuring)
- **Business Model:** Product-led growth, self-serve
- **Customer Base:** Primarily SMBs

**Philosophy:** Prioritize "real" growth opportunities (proven demand exists) over speculative initiatives.

---

## Workflow Stages

### Stage 1: Deal Discovery
**Input:** New deal appears (Acquire.com, broker, direct outreach)  
**Actions:**
- Initial screening (ARR, category, geography)
- Quick pass/fail on deal-breakers (platform dependency, enterprise-only)
- If interesting → Download materials

**Output:** Decision to proceed or pass (5 minutes)

---

### Stage 2: Document Collection
**Input:** Potentially interesting deal  
**Actions:**
- Request standard materials:
  - SIM (Seller Information Memorandum)
  - P&L (Profit & Loss statement, 2-3 years)
  - Website access
- Send initial questions to seller:
  - Customer economics (churn, cohorts, MRR trends)
  - P&L clarifications (unclear expense items)
  - Growth history and experiments
- Optional: Record founder call notes

**Output:** Complete document package (1-2 days depending on seller responsiveness)

**Document Priority:**
1. **Questions doc** (founder Q&A) - READ FIRST if exists
2. **P&L** - Financial analysis
3. **SIM** - Business description
4. **Other materials** - Supporting data

---

### Stage 3: Systematic Evaluation
**Input:** Complete document package  
**Tool:** Deal Evaluator Skill (SKILL.md in Claude.ai project)  
**Actions:**

**Step 0: P&L Interrogation (Pre-Evaluation)**
- Flag unclear expense line items >$50k
- Calculate total founder compensation
- Generate Phase 1 clarification questions if needed

**Step 1: Criteria Match (Part A)**
- Score 5 core criteria (ARR, Growth, SDE, PLG, SMB)
- Pass ≥3 criteria → Continue
- Pass <3 criteria → AUTO-PASS

**Step 2: Risk Assessment (Part B)**
- Scan for critical flags (platform dependency)
- Identify high/medium risks
- Any critical flag → PASS

**Step 3: Growth Opportunities (Part C)**
- **First:** Systematic pricing check (automatic for organic businesses)
- Identify REAL opportunities (proven demand exists)
- Separate PIE-IN-THE-SKY opportunities (speculative)
- Count: Need ≥1 REAL opportunity

**Step 4: Competitive Research (Part D)**
- Research 3-5 competitors (MANDATORY)
- Document pricing comparison
- Assess market positioning

**Step 5: Customer Economics (Part E)**
- Check for missing data (churn, cohorts, MRR)
- Flag gaps for Phase 1 questions

**Step 6: Stack Ranking**
- Calculate composite score (out of 25 or 35)
- Criteria (0-5) + Growth (0-10) + Risk (0-10) + Price (0-10)

**Output:** Comprehensive evaluation report with PURSUE/PASS recommendation (30-45 minutes)

---

### Stage 4: Interactive Discussion
**Input:** Initial evaluation report  
**Actions:**
- Review findings with Claude
- Deep-dive specific opportunities/risks
- Model scenarios (pricing changes, cost optimization)
- Challenge assumptions
- Refine understanding

**Output:** Confirmed recommendation with conviction level (15-30 minutes)

---

### Stage 5: Decision Point

**If PASS:**
- Document reason in evaluation
- Add to learnings.md if pattern identified
- Move on to next deal

**If PURSUE:**
- Generate Phase 2 questions for founder call
- Prepare for detailed due diligence
→ Proceed to Stage 6

---

### Stage 6: Deep Due Diligence (PURSUE only)
**Input:** PURSUE recommendation from Stage 5  
**Actions:**
- Schedule founder call (Phase 2 questions)
- Customer reference calls (2-3 customers)
- Technical assessment (if applicable)
- Validate growth opportunities
- Generate Phase 3 questions if needed
- Build financial model (3 scenarios: base, down, growth)

**Output:** High-conviction PURSUE or PASS decision (1-2 weeks)

---

### Stage 7: Investment Memo (PURSUE only)
**Input:** High-conviction PURSUE decision  
**Tool:** Memo Writer Skill (future)  
**Actions:**
- Generate investment memo using Evalart template structure:
  - Product description
  - Business model & metrics
  - Competition analysis
  - Strengths & opportunities
  - Weaknesses & threats
  - Financials & ROI scenarios
  - Recommendation
- Review and refine
- Share with stakeholders (Javier, others)

**Output:** Polished investment memo (1-2 hours)

---

### Stage 8: Negotiation & Close (PURSUE only)
**Input:** Approved investment memo  
**Actions:**
- Submit LOI (Letter of Intent)
- Negotiate terms
- Legal due diligence
- Close deal

**Output:** Acquisition complete or deal termination

---

### Stage 9: Post-Evaluation Learning
**Input:** Completed evaluation (PURSUE or PASS)  
**Actions:**
- Document gaps in framework (docs/learnings.md)
- Identify patterns across deals
- Update skill if systematic improvement found
- Track outcomes (deals pursued, deals passed that succeeded elsewhere)

**Output:** Framework improvements, accumulated knowledge

---

## Key Workflow Principles

### 1. Document Reading Priority
Always read in this order:
1. **Questions doc FIRST** (if exists) - contains critical missing data
2. P&L - for financial analysis
3. SIM - for business description
4. Other materials

**Rationale:** Questions docs contain MRR trends, churn data, untapped opportunities that change evaluations.

### 2. P&L Interrogation Before Scoring
Never score criteria without first:
- Flagging unclear expenses >$50k
- Calculating total founder compensation
- Understanding what's removable vs. essential

**Rationale:** $200k+ in hidden economics can change SDE from 35% → 55%.

### 3. Systematic Pricing Investigation
For businesses with >70% organic/SEO traffic:
- **Always** check: When was last price increase?
- If >3 years → Automatic competitor pricing research
- Competitors 50%+ more expensive = REAL opportunity

**Rationale:** Pricing is #1 undermonetization lever for organic businesses.

### 4. Context-Based Growth Assessment
When growth is declining, ask WHY:
- **Structural decline** (market shrinking, obsolescence) = FAIL
- **Underexecution decline** (never raised prices, cut marketing) = OPPORTUNITY

**Rationale:** Fixable underexecution shouldn't disqualify good businesses.

### 5. Real vs. Speculative Opportunities
**REAL = Proven demand exists:**
- Competitors successfully using channel X
- Business 50%+ underpriced vs. market
- Owned distribution never activated (email lists, in-product virality)

**PIE-IN-THE-SKY = Unproven:**
- "Never tried marketing"
- "Could build sales team"
- Hypothetical products

**Rationale:** Only value real opportunities in pricing/recommendation.

### 6. Interactive, Not Automated (Phase 1)
Current workflow uses Claude skill interactively:
- See reasoning step-by-step
- Course-correct mid-evaluation
- Discuss findings before finalizing
- Adapt to edge cases

**Future:** Migrate to sub-agents when evaluating 5+ deals/week.

---

## Workflow Outputs

### Primary Outputs
1. **Evaluation Report** (Stage 3)
   - Executive summary (PURSUE/PASS)
   - Criteria scoring
   - Risk assessment
   - Growth opportunities
   - Competitive analysis
   - Stack ranking score
   
2. **Investment Memo** (Stage 7, PURSUE only)
   - Complete business analysis
   - Financial modeling
   - Risk/opportunity assessment
   - Recommendation with conviction

### Secondary Outputs
3. **Phase 1/2/3 Questions** (as needed)
   - P&L clarifications
   - Customer economics data
   - Founder call questions
   
4. **Learnings Documentation** (Stage 9)
   - Framework gaps identified
   - Patterns recognized
   - Skill improvements needed

---

## Success Metrics

### Evaluation Quality
- **Accuracy:** Did we correctly identify opportunities/risks?
- **Efficiency:** <45 minutes for initial evaluation
- **Consistency:** Same inputs → same outputs
- **Completeness:** All critical questions answered

### Decision Quality
- **No false negatives:** Don't miss good deals (like SurveyPlanet initially)
- **No false positives:** Don't pursue bad deals
- **Clear rationale:** Can explain decision in 2 sentences
- **Defensible:** Withstands scrutiny from Javier/others

### Process Quality
- **Documented:** All evaluations tracked in learnings.md
- **Improved:** Framework evolves based on real experience
- **Repeatable:** Anyone can follow the process
- **Scalable:** Ready to migrate to automation when volume increases

---

## Workflow Dependencies

### Tools
- **Claude.ai Project:** "Deal Flow" with deal-evaluator skill
- **GitHub Repository:** https://github.com/noosalabs/deal-flow-review
- **Communication:** Email, Acquire.com messaging, video calls

### Skills
- **deal-evaluator** (v2.0) - Current
- **memo-writer** (future) - In development

### Data Sources
- **Deal platforms:** Acquire.com, Flippa, brokers
- **Research:** Competitors' websites, G2, Capterra
- **Validation:** Customer calls, founder Q&A

---

## Workflow Variations

### Fast Track (High-Confidence PASS)
- Stage 1 → Stage 2 (basic docs) → Stage 3 (evaluation) → PASS
- **Use when:** Multiple criteria failures, critical risk flag obvious
- **Time:** 1-2 hours total

### Standard Track (Most Deals)
- All stages 1-5 → Decision point → PASS
- **Use when:** Borderline deals, needs investigation
- **Time:** 2-4 hours spread over 1 week

### Deep Track (High-Conviction PURSUE)
- All stages 1-8 → Close or pass after deep DD
- **Use when:** Strong candidate, worth extensive diligence
- **Time:** 10-20 hours spread over 2-4 weeks

---

## Workflow Maintenance

### After Each Evaluation
- Document gaps in docs/learnings.md
- Note if framework update needed

### Weekly (If Active)
- Review week's evaluations
- Identify patterns

### Monthly
- Batch update skill with accumulated learnings
- Re-upload to Claude project

### Quarterly
- Major framework review
- Consider architectural changes
- Review success metrics

---

## Evolution Path

### Phase 1: Interactive Skill (Current)
**Status:** In use  
**Volume:** 1-2 deals/week  
**Method:** Claude.ai project with skill  
**Characteristics:** Interactive, flexible, learning

### Phase 2: Sub-Agent Automation (6-12 months)
**Trigger:** 5+ deals/week, framework stable  
**Volume:** 5-20 deals/week  
**Method:** Claude Code agents  
**Characteristics:** Autonomous, batch processing, consistent

**Migration Path:**
1. Stabilize framework (20+ evaluations)
2. Structured output format (JSON schema)
3. Build agent configuration
4. Orchestration layer
5. Hybrid approach (skill for complex, agent for standard)

See `docs/future-architecture.md` for detailed roadmap.

---

## Workflow Roles

### Primary Owner (Pascal)
- Execute workflow for all deals
- Make PURSUE/PASS decisions
- Approve investment memos
- Update framework based on learnings

### Supporting Role (Claude)
- Execute evaluation framework
- Generate reports and memos
- Identify patterns across deals
- Suggest framework improvements

### Review Role (Javier)
- Review investment memos
- Challenge assumptions
- Approve large acquisitions
- Provide operational perspective

---

## Related Documents

- **SKILL.md** - Complete evaluation framework
- **docs/learnings.md** - Accumulated insights from deals
- **docs/skill-development.md** - How to improve workflow
- **docs/future-architecture.md** - Automation roadmap
- **examples/** - Real evaluation examples

---

## Change Log

### v2.0 (2026-02-13)
Major update based on SurveyPlanet evaluation:
- Added P&L interrogation (Step 0)
- Systematic pricing checks
- Context-based growth assessment
- Document reading priority
- Customer economics validation

### v1.0 (2023)
Initial workflow based on Evalart acquisition

---

## Questions & Support

- **Framework questions:** See docs/skill-development.md
- **Technical setup:** See SETUP_GUIDE.md
- **Future automation:** See docs/future-architecture.md
- **Pattern questions:** See docs/learnings.md

**Repository:** https://github.com/noosalabs/deal-flow-review
