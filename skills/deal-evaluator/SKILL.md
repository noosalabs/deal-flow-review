---
name: deal-evaluator
description: Systematically evaluates micro-SaaS acquisition opportunities against investment criteria, identifies risks and growth opportunities, produces stack-ranked recommendations. Use when Pascal uploads deal documents (SIM, P&L, website notes) and needs comprehensive evaluation against his acquisition criteria. The skill applies a rigorous 5-point criteria check, scans for critical risk flags (especially platform dependencies), categorizes growth opportunities as real vs. speculative, researches competitors, and produces a final recommendation with stack ranking.
---

# Deal Evaluator

Evaluate micro-SaaS acquisition opportunities using Pascal's systematic investment criteria and produce actionable recommendations with supporting analysis.

## Investment Thesis

**Target Profile:**
- ARR: >$200k (no upper limit, but SDE must be <$700k for affordability)
- Growth: >10% year-over-year (or explainable decline with clear recovery path)
- SDE (Seller's Discretionary Earnings): >50% (or achievable through optimization)
- Business model: Product-led growth
- Customer base: Primarily small businesses
- Philosophy: Prioritize "real" growth opportunities (proven demand) over speculative initiatives

**Affordability Constraint:** 
- Target SDE: <$700k (sets maximum affordable acquisition price)
- If SDE >$700k, deal is likely outside budget even if attractive

## Document Reading Priority

**CRITICAL**: If multiple documents are provided, read them in this order:

1. **Questions Document FIRST** (if exists)
   - Often titled "questions for [company]" or "founder Q&A"
   - Contains critical data often missing from SIM/P&L: MRR trends, cohort data, churn rates, growth experiments, untapped opportunities
   - Can completely change evaluation (e.g., revealing pricing never raised, databases never used)
   - **Read this BEFORE forming preliminary judgment**

2. **P&L / Financial Statements**
   - Revenue trends, expense breakdown, profitability
   - Flag unclear line items immediately (see Part A, Step 0)

3. **SIM (Seller Information Memorandum)**
   - Product description, market positioning, customer base
   - Often marketing-heavy, verify claims against P&L

4. **Other docs** (customer lists, metrics dashboards, etc.)

## Evaluation Framework

### PART A: Criteria Match (Hard Filters)

**STEP 0: Interrogate P&L Before Scoring**

Before evaluating criteria, scan P&L for unclear expense line items that could change economics:

**Red flags requiring immediate clarification:**
- Vague line items >$50k: "Outside Services," "Consulting," "Outsourcing," "Management Fees," "Contract Labor"
- Multiple potential founder compensation categories
- Unusual spikes or one-time costs
- Missing expense categories (no hosting costs for SaaS? No payment processing fees?)

**Action**: List these items in "P&L Clarification Needed" section of output. These are Phase 1 email questions.

**Why critical**: A $200k "Outside Services" item that's actually founder payment can swing SDE from 35% to 55%.

---

Score each deal on 5 core criteria:

**1. ARR in Range (>$200k, SDE <$700k)**
- Extract annual recurring revenue from P&L or SIM
- **Minimum**: $200k (below this, too small to be interesting)
- **Affordability check**: Calculate SDE in dollars - if >$700k, likely too expensive
- Note: High ARR (>$1M) is fine if SDE is affordable and growth is strong

**2. Growth Rate >10% Year-over-Year**
- Calculate YoY growth from P&L data
- Look at trailing 12 months if available
- Consider trajectory: accelerating, steady, or decelerating
- **CRITICAL**: If declining, assess WHY before failing criterion:

**Declining Growth Context Assessment:**
Ask: "Is this decline structural or due to underexecution?"

- **STRUCTURAL (FAIL criterion):**
  - Market shrinking (e.g., Flash-based tools in 2020)
  - Competitor disruption (cheaper/better alternative emerged)
  - Regulatory changes hurting demand
  - Technology obsolescence
  - Evidence: Competitors also declining, category search volume down
  
- **UNDEREXECUTION (POTENTIAL OPPORTUNITY - PASS criterion):**
  - Never raised prices despite competitor increases
  - Never activated obvious distribution channels (email lists, partnerships)
  - Declining marketing spend without strategic reason
  - Founder burnout / reduced time investment
  - Technical debt causing conversion issues
  - Evidence: Obvious untapped levers, questions doc reveals "never tried X"
  
**Example Underexecution Patterns:**
- Revenue declining 5-10% YoY BUT:
  - Never raised prices in 15 years (while competitors raised 30-50%)
  - 1M+ user email database never contacted
  - Google AdWords spend dropped 95% without replacement channel
  - These are FIXABLE = treat as opportunity, not fatal flaw

**Decision**: If decline is due to underexecution with clear recovery path, PASS this criterion and note opportunities in Part C.

- Red flag: Decelerating growth without clear explanation or recovery path

**3. SDE >50% (or Achievable)**
- Calculate: (Revenue - Operating Costs) / Revenue
- **CRITICAL FIRST STEP**: Identify all founder/owner compensation across P&L:
  - Officer/Owner salary
  - Distributions, draws, bonuses
  - "Consulting fees," "Outside Services," "Outsourcing" paid to owner
  - Management fees
  - **Add these up = Total Founder Compensation**
- If below 50%, assess achievability:
  - **Team restructuring**: Can founder work part-time + hire cheaper replacement?
    - Example: $500k total comp → $125k part-time + $50k new hire = $350k savings
  - Can team be optimized? (US team → lower-cost geographies, AI automation)
  - Are there one-time costs inflating the expense base?
  - **Flag unclear expenses**: Any line item >$50k with vague name needs clarification
  - Caution: If requires replacing experienced team (10-15 years tenure), not achievable
- Note percentage and path to 50%+ if applicable
- **Output**: Show both current SDE and post-acquisition achievable SDE

**4. Product-Led Growth Model**
- Does the product have self-serve signup?
- Can customers activate and get value without sales intervention?
- What % of revenue comes through self-serve vs. sales-assisted?
- Red flag: Heavy dependency on manual sales for SMB customers

**5. Sells Primarily to Small Businesses**
- Who are the customers? (size, industry, use case)
- Preference: SMBs over enterprise
- Red flag: Long sales cycles, enterprise-only procurement

**Decision Logic:**
- **Pass 5/5**: Strong candidate → proceed to Part B
- **Pass 4/5**: Good candidate → note which criterion failed and why, proceed to Part B
- **Pass 3/5**: Borderline → proceed to Part B but flag as marginal
- **Pass 2/5 or fewer**: **AUTOMATIC PASS** → do not continue evaluation

**Borderline Criterion Investigation:**
If exactly 1 criterion fails, investigate:
- Is this failure **permanent** (structural to the business) or **temporary** (market conditions, founder decisions)?
- Example temporary: Low growth in 2023 due to market downturn but recovering
- Example permanent: Enterprise-only product that can't be adapted for SMB

### PART B: Critical Risk Flags

Scan for **deal-breaker risks**. Any ONE of these flags = PASS recommendation.

**1. Extreme Customer Concentration**
- Look for: <10 customers generating >50% of revenue
- Risk: Each lost customer = major revenue hit
- Severity: CRITICAL

**2. Cash Flow Timing Issues**
- Look for: All/most customers on annual contracts that just renewed
- Risk: 11+ months with no incoming cash flow
- Severity: CRITICAL (affects acquisition financing)

**3. Platform Dependency (Product-Side)**
- **CRITICAL HEURISTIC**: Strong dependency on Meta (Facebook, Instagram, WhatsApp) or LinkedIn platforms
- Specifically dangerous:
  - Product requires Meta/LinkedIn APIs for core functionality
  - Business model depends on Meta/LinkedIn data access
  - Revenue tied to Meta/LinkedIn platform policies
- **ACCEPTABLE**: Using Meta/LinkedIn for advertising only (not product dependency)
- Historical context: Pascal has had bad experiences with both platforms (policy changes, API restrictions, arbitrary shutdowns)
- Severity: CRITICAL
- Additional platforms to watch: Any product built on top of a platform that could shut down access

**4. AI Displacement Threat**
- Could Claude, ChatGPT, or other AI models replace this product's core value prop?
- Examples:
  - Basic content generation → High risk
  - Simple data extraction/transformation → High risk
  - Workflow automation with clear rules → Medium risk
  - Domain-specific expertise + human judgment → Low risk
- Severity: HIGH to CRITICAL depending on timeline to displacement

**5. Severe Founder Dependency**
- Is all/most revenue tied to founder's personal reputation, relationships, or network?
- Can the business operate without the founder's active involvement?
- Red flags:
  - All customers are founder's personal contacts
  - Revenue depends on founder's thought leadership/speaking
  - No systematic acquisition channels (all word-of-mouth from founder network)
- Severity: HIGH to CRITICAL

**6. Negative Trajectory**
- **Declining revenue + rising costs** = death spiral
- **Accelerating churn** (not just high churn, but getting worse)
- **CAC rising faster than revenue** = unsustainable growth
- Severity: CRITICAL

### PART C: Growth Opportunity Assessment

Categorize opportunities as **REAL** or **PIE-IN-THE-SKY** based on evidence of proven demand.

**SYSTEMATIC PRICING CHECK (Always Evaluate First)**

For SEO/organic-driven businesses, pricing is often the #1 untapped lever. Check systematically:

**Step 1: Automatic Triggers** (Look for these signals)
1. **When was the last price increase?**
   - Look in SIM, founder questions doc, or ask
   - If >3 years ago (or never): **Strong pricing opportunity signal**
   - If >5 years: **Very strong signal** (founder discomfort with pricing likely)
   
2. **Price visibility**:
   - Are prices shown on website? (If no: founder discomfort signal)
   
3. **Customer price sensitivity**:
   - What % of customers complain about price?
   - If <5%: Strong underpricing signal
   - If churn reason "price" is <10%: Pricing power exists

**Step 2: Competitor Pricing Research** (MANDATORY - always do this)
- Use web search: "[product category] pricing", "[competitor name] pricing"
- Document 3-5 competitors' pricing tiers (entry, mid, premium)
- Compare features offered at each price point
- Calculate price gap: `(Competitor Price - Deal Price) / Deal Price × 100%`
   
**Step 3: Categorize Pricing Opportunity**
- **REAL (HIGH CONFIDENCE)**: 
  - Competitors charge 50-100%+ more for similar value
  - Last increase >3 years ago (or never)
  - Business has >70% organic/SEO traffic (price-insensitive customers)
  - Evidence: Market has validated higher prices, customers aren't churning due to price
  - Impact calculation: `Current MRR × Price Increase % × 0.95` (assume 5% churn)
  - Risk: LOW to MEDIUM
  
- **REAL (MEDIUM CONFIDENCE)**:
  - Competitors charge 30-50% more
  - Requires testing, but market signal is clear
  - Risk: MEDIUM
  
- **PIE-IN-THE-SKY**:
  - Competitors charge 1.1-1.3x more (within margin of error)
  - Recent price increase (<2 years ago)
  - No clear market validation for higher pricing
  
- **No Opportunity**: At or above market pricing

**Step 4: Calculate Impact**
Example:
- Current: $20/mo × 2,725 customers = $54k MRR = $648k ARR
- New: $29/mo × 2,589 customers (5% churn) = $75k MRR = $900k ARR
- **Net Impact: +$252k ARR** (+39%)
- Risk: LOW (still cheapest option, 38% of customers retained 2+ years)

**Example Output**: 
```
SYSTEMATIC PRICING CHECK:
- Last price increase: Never (15 years) ← Strong signal
- Customer complaints about price: "We rarely get complaints" ← Strong signal
- Organic traffic: 78% ← Price-insensitive customers
- Competitor research:
  - SurveyMonkey: $39/mo (+95%)
  - Typeform: $29/mo (+45%)
  - Jotform: $34/mo (+70%)
  - Deal pricing: $20/mo
- Price gap: 45-95% below market
- REAL opportunity: Raise to $29/mo (45% increase)
- Impact: +$252k ARR
- Risk: LOW (still cheapest option, sticky customer base)
```

**REAL Opportunities (Proven Demand Exists)**

These are actionable initiatives with validation:

1. **Competitor Validation**
   - Other players successfully using distribution channel X
   - This business not yet on that channel
   - Example: "Competitors are on Product Hunt, this product isn't"
   - Validation: Use web search to confirm competitor presence

2. **Clear Underpricing** (see Systematic Pricing Check above)
   - Competitors charge 2-3x more for similar value
   - Research competitor pricing via web search
   - Validate: Compare feature sets, not just price
   - Example: "Competitor charges $200/mo for same features, this charges $50/mo"

3. **Validated Geographic/Segment Expansion**
   - Demand exists in adjacent geography/segment
   - Competitors already serving that market
   - Minimal product changes required
   - Example: "Strong in LatAm, competitors succeeding in Spain/Portugal with same product"

4. **Untapped Distribution Platforms**
   - Platform exists where target customers already shop
   - Competitors have integrations, this business doesn't
   - Example: "Not in Shopify app store, but 3 competitors are"

5. **ATS/Ecosystem Partnerships**
   - Relevant to SaaS tools that integrate with ATS, CRM, etc.
   - Partnership opportunities where competitors have existing integrations
   - Example: "No BambooHR integration, but customers use BambooHR"

6. **Untapped Owned Distribution Channels** (NEW - distinguish from "never tried marketing")
   - Business owns distribution but never activates it
   - Examples:
     - **Email database**: Large user base never contacted (proven tactic: everyone emails users)
     - **Existing customer upsell**: Free users never pitched paid plans systematically
     - **In-product virality**: Viral loops exist but not optimized
   - **NOT the same as**: "Never tried outbound" or "Never tried ads" (those are speculative)
   - **Distinction**: Channel exists and is owned, just needs activation

**PIE-IN-THE-SKY Opportunities (Speculative, Unproven)**

These are low-confidence or require significant risk:

1. **"We've never tried marketing"**
   - No evidence it will work
   - Don't price this into valuation
   - Pascal's take: If marketing worked, someone would have tried it

2. **"We could do outbound sales"**
   - Requires building sales team, processes, playbook
   - Unproven channel for this product
   - High execution risk

3. **Hypothetical New Products**
   - "We could build X feature for Y market"
   - No customer demand validation
   - Speculative roadmap items

4. **"AI will unlock new use cases"**
   - Unless specific use cases with identified customers
   - Don't count as growth opportunity

**Opportunity Analysis Output:**
- List 3-5 REAL opportunities with evidence
- List PIE-IN-THE-SKY opportunities separately (to show you identified them but don't rely on them)
- For each REAL opportunity: What's the evidence? Who else is doing it successfully?

### PART D: Competitive Research & Positioning (MANDATORY)

**This section is NOT optional. Always complete competitive research before finalizing evaluation.**

Use web search to:

1. **Identify Competitors**
   - Named in SIM
   - Found via search: "[product category] software for [target market]"
   - Check: G2, Capterra, Product Hunt for similar tools

2. **Research Competitor Pricing**
   - Visit competitor websites
   - Document pricing tiers
   - Compare to deal's pricing
   - Calculate price gap (overpriced, underpriced, market rate)

3. **Assess Market Positioning**
   - How does this product differentiate?
   - What's the unique angle? (Geography, feature set, price, support)
   - Is there a defendable moat?

4. **Market Opportunity**
   - Is this a growing category?
   - Who are the major players?
   - Is there room for a niche player?
   - Specific angle: LatAm opportunities where US competitors haven't localized

**Competitive Analysis Output:**
- 3-5 key competitors with pricing
- Positioning assessment (where does this fit in the landscape?)
- Market size/growth indication (if available)

---

### PART E: Customer Economics Check (Generate Questions if Missing)

Critical data often missing from SIM/P&L but essential for evaluation:

**Required Data Points:**
1. **New customers per month** (or quarter)
2. **Churn rate** (monthly or annual %)
3. **Cohort retention** (what % of customers from 12 months ago still paying?)
4. **MRR trend** (last 12 months)
5. **Customer segments** (individuals vs. teams vs. enterprise - size and behavior)
6. **Upgrade path data** (free→paid conversion %, paid→enterprise %)

**If ANY of these are missing from documents:**
- Flag in evaluation output under "Missing Critical Data"
- Generate Phase 1 email questions to collect this data
- Note: Cannot fully assess opportunity without this data

**Why critical**: 
- High churn + declining MRR = death spiral (even if revenue growing from new customer volume)
- Strong cohort retention + low churn = pricing power
- High free→paid conversion = product value clear
- Low conversion = product value unclear or positioning wrong

**Example Output:**
```
MISSING CRITICAL DATA:
- Churn rate (monthly/annual)
- Cohort retention (12-month)
- MRR trend over last 12 months

PHASE 1 EMAIL QUESTIONS NEEDED:
1. What's your monthly churn rate?
2. Of customers who started 12 months ago, what % are still paying today?
3. Can you share MRR for each of the last 12 months?
```

---

## Stack Ranking Methodology

Calculate composite score to prioritize multiple deals:

**Step 1: Criteria Match Score (0-5 points)**
- 5 points: Passes all 5 criteria
- 4 points: Passes 4 criteria
- 3 points: Passes 3 criteria
- <3: Auto-fail, no ranking

**Step 2: Growth Opportunity Score (0-10 points)**
- Count REAL opportunities (not pie-in-the-sky)
- 0 real opportunities: 0 points
- 1 real opportunity: 4 points
- 2 real opportunities: 7 points
- 3+ real opportunities: 10 points

**Step 3: Risk Profile Score (0-10 points)**
- Start with 10 points
- Any critical risk flag: 0 points (deal-breaker)
- High-severity risks (not critical): -3 points each
- Medium-severity risks: -1 point each

**Step 4: Price Multiple Score (0-10 points)**
- Only if asking price is provided
- Calculate: Asking Price / ARR
- Scoring:
  - <1.5x ARR: 10 points (great price)
  - 1.5-2x ARR: 8 points (good price)
  - 2-2.5x ARR: 6 points (fair price)
  - 2.5-3x ARR: 4 points (high price)
  - 3-4x ARR: 2 points (very high price)
  - >4x ARR: 0 points (overpriced)
- If no price: Skip this factor (score out of 25 instead of 35)

**Step 5: Calculate Composite Score**
- With price: (Criteria + Growth + Risk + Price) / 35 = % score
- Without price: (Criteria + Growth + Risk) / 25 = % score

**Step 6: Stack Ranking**
- Sort deals by composite score descending
- Ties broken by: Growth score → Risk score → Criteria match

## Output Format

Produce a comprehensive evaluation report:

```markdown
# Deal Evaluation: [Company Name]

## Executive Summary
[2-3 sentence recommendation: PURSUE or PASS with key rationale]

---

## P&L CLARIFICATION NEEDED (If Applicable)

[List any unclear expense line items >$50k that need explanation]

**Example:**
- "Outside Services" ($234k) - What is this? Owner compensation? Contractors?
- "Outsourcing" ($80k) - Same question
- Officer Salary ($288k) + Outside Services ($234k) = $522k total - Is this all founder comp?

**Phase 1 Email Questions:**
1. [Question about specific line item]
2. [Question about total founder compensation]

---

## MISSING CRITICAL DATA (If Applicable)

[List customer economics data not found in SIM/P&L]

**Phase 1 Email Questions Needed:**
1. What's your monthly/annual churn rate?
2. How many new paid customers do you add per month?
3. Of customers who started 12 months ago, what % are still paying?
4. Can you share MRR for the last 12 months?
5. What's your free-to-paid conversion rate?

---

## PART A: Criteria Match

**ARR: [✓/✗]** $[amount] - [in range / below range / above range]

**Growth: [✓/✗]** [X]% YoY - [accelerating / steady / decelerating]
- [If available: Monthly breakdown or trend analysis]

**SDE: [✓/✗]** [X]% - [Current margin, achievable margin if different]
- Revenue: $[amount]
- Current operating costs: $[amount]
- **Current SDE: $[amount] ([X]%)**
- [If below 50%: Show achievable SDE calculation]
  - Total founder compensation: $[amount] (itemize: salary + outside services + etc.)
  - Post-acquisition structure: [describe team restructuring]
  - Revised operating costs: $[amount]
  - **Achievable SDE: $[amount] ([X]%)** ✓/✗

**Product-Led Growth: [✓/✗]** [Yes/No + explanation]
- Self-serve signup: [Yes/No]
- Sales involvement: [%]

**SMB Focus: [✓/✗]** [Yes/No + customer profile]

**RESULT:** Passes [X] of 5 criteria → [CONTINUE / AUTOMATIC PASS]

[If 1 criterion fails: Analysis of whether temporary or permanent]

---

## PART B: Critical Risk Flags

[List each risk category and finding]

**Customer Concentration:** [✓ No issue / ⚠ Flag identified]
[Details if flagged]

**Cash Flow Timing:** [✓ No issue / ⚠ Flag identified]
[Details if flagged]

**Platform Dependency:** [✓ No issue / 🚨 CRITICAL FLAG]
[Details - specifically check for Meta/LinkedIn product dependencies]

**AI Displacement:** [✓ Low risk / ⚠ Medium risk / 🚨 High risk]
[Analysis of vulnerability]

**Founder Dependency:** [✓ No issue / ⚠ Flag identified]
[Details if flagged]

**Negative Trajectory:** [✓ No issue / 🚨 CRITICAL FLAG]
[Details if flagged]

**RESULT:** [No critical flags identified / CRITICAL FLAG: {issue} - RECOMMEND PASS]

---

## PART C: Growth Opportunities

### REAL Opportunities (Proven Demand)

1. **[Opportunity Name]**
   - Evidence: [What proves demand exists?]
   - Validation: [Competitor examples, market data]
   - Estimated impact: [Revenue potential, timeline]

2. [Continue for each real opportunity]

### PIE-IN-THE-SKY Opportunities (Speculative)

1. **[Opportunity Name]**
   - Why speculative: [What's unproven?]
   - Risk level: [High/Medium]

[List but don't count these in growth score]

**Real Opportunity Count:** [X] opportunities

---

## PART D: Competitive Landscape

**Key Competitors:**
1. [Competitor Name] - $[pricing] - [positioning]
2. [Continue for 3-5 competitors]

**Pricing Comparison:**
- This deal: $[price]
- Market average: $[price]
- Assessment: [Underpriced 2-3x / Market rate / Overpriced]

**Market Positioning:**
[Where does this fit? What's unique?]

**Competitive Moat:**
[Defensibility assessment]

---

## Stack Ranking Score

**Criteria Match:** [X]/5 points
**Growth Opportunities:** [X]/10 points ([Y] real opportunities)
**Risk Profile:** [X]/10 points [Any flags reduce score]
**Price Multiple:** [X]/10 points ([Z]x ARR) [If price provided]

**COMPOSITE SCORE: [XX]%** [or /25 if no price]

---

## Growth Thesis (If PURSUE)

[2-4 sentences describing credible path to growth]

Example: "This business can grow through three validated channels: (1) pricing increase from $50 to $150/mo (competitors charge $200/mo), (2) Shopify app store distribution (3 competitors present, generating 30% of their leads), and (3) LatAm geographic expansion where no competitors offer Spanish support. These are execution plays with proven demand, not speculative bets."

---

## Recommendation

**[PURSUE / PASS]**

**Rationale:**
[Key reasons supporting the recommendation]

**Next Steps (if PURSUE):**
1. Generate Phase 1 questions [if criteria uncertainty or P&L anomalies]
2. Prepare founder call questions
3. Schedule founder interview

**Deal-Killer (if PASS):**
[What made this a no-go?]
```

## Workflow

When invoked:

**STEP 0: Check for Additional Documents**
- If a "questions" document exists (Word doc with founder Q&A), **read it first**
- Questions documents often contain critical data missing from SIM/P&L:
  - MRR trends, churn rates, cohort data
  - Customer acquisition metrics
  - Founder's view on opportunities
  - Untapped growth levers
- This document can change evaluation from PASS → PURSUE

1. **Parse Documents**
   - Extract key metrics from P&L (ARR, revenue trends, costs, margins)
   - **CRITICAL**: Identify unclear expense line items >$50k (flag for Phase 1 questions)
   - **CRITICAL**: Calculate total founder compensation across all P&L categories
   - Extract business model info from SIM
   - Review website notes for product assessment
   - If questions document exists, extract customer economics data

2. **Execute Part A: Criteria Match**
   - Score each of 5 criteria
   - Calculate pass/fail count
   - Determine if evaluation should continue

3. **Execute Part B: Risk Flags** (if Part A passes)
   - Systematically check each risk category
   - **Pay special attention to platform dependencies** (Meta/LinkedIn)
   - Flag any critical issues

4. **Execute Part C: Growth Opportunities** (if no critical flags)
   - **First**: Run systematic pricing check
     - When was last price increase?
     - Research competitor pricing (mandatory web search)
     - Calculate pricing opportunity if exists
   - Identify other opportunities from SIM and analysis
   - Categorize as REAL vs. PIE-IN-THE-SKY
   - Count real opportunities for scoring

5. **Execute Part D: Competitive Research** (MANDATORY)
   - Use web search to find competitors
   - Research pricing
   - Assess positioning

6. **Execute Part E: Customer Economics**
   - Check if critical data exists (churn, cohorts, MRR trends, new customers/month)
   - If missing, flag for Phase 1 email questions
   - Note gaps in evaluation output

6. **Execute Part E: Customer Economics**
   - Check if critical data exists (churn, cohorts, MRR trends, new customers/month)
   - If missing, flag for Phase 1 email questions
   - Note gaps in evaluation output

7. **Calculate Stack Rank Score**
   - Apply scoring methodology
   - Generate composite score

8. **Generate Recommendation**
   - PURSUE if: Pass Part A (3+ criteria) + 1+ real opportunity + no critical flags
   - PASS if: Fail Part A (2+ criteria) OR any critical flag OR zero real opportunities
   - Note: P&L clarifications or missing customer data may change recommendation

9. **Output Evaluation Report**
   - Follow format above
   - Include P&L clarification section if needed
   - Include missing data section if needed
   - Be specific with numbers, names, evidence
   - Make recommendation clear and defensible

## Critical Reminders

**Always use web search for:**
- Competitor identification
- Pricing research (MANDATORY, not optional)
- Market validation

**Always interrogate P&L before scoring:**
- Unclear line items >$50k need immediate clarification
- Calculate total founder compensation across all categories
- These clarifications can swing SDE from failing to passing
- Example: $234k "Outside Services" was actually CEO payment, changed SDE from 37.7% to 54.2%

**Pricing check is systematic, not opportunistic:**
- For SEO/organic businesses, ALWAYS check when last price increase happened
- If >3 years (or never), automatic pricing research trigger
- Competitors charging 50%+ more = REAL opportunity, not speculative
- "Never raised prices" is a massive red flag for undermonetization
- If customer complaints about price are <5%, pricing power exists

**Questions document changes everything:**
- If founder Q&A document exists, READ IT FIRST before forming judgment
- Often reveals: MRR trends, churn data, cohorts, untapped opportunities
- Can flip evaluation from PASS → PURSUE (as seen with SurveyPlanet)
- Contains data that SIM/P&L never include

**Declining growth needs context:**
- Don't auto-fail on declining growth
- Ask: "Structural decline or underexecution?"
- Declining revenue + obvious untapped levers (pricing, email, partnerships) = OPPORTUNITY
- Declining revenue + no clear recovery path = STRUCTURAL FAILURE
- Example: -8% growth but never raised prices in 15 years = fixable

**Distinguish owned distribution from speculative marketing:**
- "Never emailed 1M user database" = REAL opportunity (proven tactic)
- "Never tried outbound sales" = PIE-IN-THE-SKY (unproven for this business)
- Key difference: Do they own the channel or need to build it?

**Be ruthless about platform dependencies:**
- Meta/LinkedIn product dependencies = CRITICAL FLAG
- Don't soften this based on founder assurances
- Pascal's experience: These platforms are unpredictable and dangerous

**Real vs. Pie-in-the-Sky distinction matters:**
- Real = Someone else is already doing it successfully
- Pie-in-the-Sky = "We could try X" without validation
- This distinction drives valuation and risk assessment

**SDE achievability nuance:**
- Team with 10-15 years tenure = hard to replace
- Recent hires, US-based team = potentially optimizable
- One-time costs inflating expenses = achievable if removed
- Don't assume you can cut costs without understanding the business

**Growth rate context:**
- Absolute rate matters, but trajectory matters more
- 15% growth that's decelerating < 8% growth that's accelerating
- Explain the trend, don't just report the number

## Edge Cases

**Deal is 51% on criteria match (passes exactly 3):**
- Continue evaluation but flag as marginal
- Higher bar for growth opportunities (need 2+ real opportunities)
- Stack rank will naturally deprioritize vs. stronger candidates

**ARR above target range but SDE is affordable:**
- Original guidance: $180k-$700k ARR range
- Reality: ARR >$700k is FINE if SDE <$700k
- The constraint is affordability (SDE), not ARR
- Example: $761k ARR with $412k achievable SDE = GOOD FIT
- Example: $500k ARR with $800k SDE = TOO EXPENSIVE
- Always calculate SDE in dollars, not just %

**Asking price not provided:**
- Skip price multiple score
- Calculate composite out of 25 instead of 35
- Note in report that price multiple couldn't be assessed

**SIM doesn't name competitors:**
- Use web search: "[product category] for [target market]"
- Search G2/Capterra for category
- Document that competitors were found via research, not SIM

**Founder claims "no platform dependency" but product uses Meta API:**
- Investigate: Is it core functionality or peripheral?
- Default to CRITICAL FLAG if any doubt
- Better to pass a good deal than pursue a risky one

**Multiple borderline factors (not quite critical flags):**
- Use risk scoring to accumulate impact
- Example: Medium customer concentration + some founder dependency + moderate AI risk = net negative
- Explain how factors compound in recommendation

## Success Criteria

A good evaluation report:
- ✅ Takes clear stance (PURSUE or PASS with conviction)
- ✅ Provides specific evidence (numbers, names, examples)
- ✅ Explains reasoning transparently
- ✅ Identifies both opportunities and risks
- ✅ Enables Pascal to make decision in 15-20 minutes of review
- ✅ Catches red flags Pascal might have missed
- ✅ Provides defensible stack ranking for prioritization
