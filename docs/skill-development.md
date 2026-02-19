# Skill Development Guide

How to improve and maintain the deal evaluation framework.

## Philosophy

Skills evolve through **real evaluation experience**, not speculation. Every update should be grounded in:
1. A specific deal that exposed a gap
2. A clear pattern that emerged across multiple deals
3. A demonstrable improvement in evaluation quality

**Anti-pattern:** Adding complexity without validation.

## Update Triggers

### When to Update the Skill

✅ **DO update when:**
- Real evaluation revealed gap (e.g., SurveyPlanet P&L confusion)
- Pattern emerged across 3+ deals (e.g., underpricing in organic businesses)
- Edge case created confusion (e.g., high ARR but affordable SDE)
- Framework missed opportunity/risk that was obvious in hindsight
- Evaluation took significantly longer than expected due to process gap

❌ **DON'T update when:**
- Hypothetical "what if" scenarios
- Adding features without clear use case
- Making framework more complex without clear benefit
- Based on single unusual deal that won't repeat

### Evaluation Retrospective Questions

After each deal evaluation, ask:

1. **Did the framework catch what matters?**
   - Were opportunities identified?
   - Were risks flagged?
   - Was the PURSUE/PASS call correct?

2. **What did we miss?**
   - What did you catch that the framework didn't?
   - What context was needed but not explicitly called out?

3. **What was inefficient?**
   - What took longer than necessary?
   - What questions came too late?
   - What research should have been automatic?

4. **What was unclear?**
   - Were instructions ambiguous?
   - Did Claude struggle with any section?
   - Were examples insufficient?

## Update Process

### Step 1: Document the Gap

Create entry in `docs/learnings.md`:

```markdown
### [Deal Name] - [Date]
**Gap Identified:** [What the framework missed]
**Impact:** [How this affected evaluation quality]
**Example:** [Specific situation]
**Proposed Fix:** [How to address this]
```

### Step 2: Design the Solution

Ask:
- **Is this systematic?** (Will this help future evaluations?)
- **Is this the minimum change?** (Smallest edit that fixes the gap?)
- **Is this clear?** (Will Claude understand the instruction?)
- **Is this tested?** (Can we validate it works?)

**Design principles:**
- Prefer heuristics over judgment calls
- Prefer automatic over optional
- Prefer specific over vague
- Prefer examples over descriptions

### Step 3: Update SKILL.md

Location of common updates:

**New trigger/heuristic:**
→ Add to relevant Part (A/B/C/D/E)
→ Add example showing usage
→ Update "Critical Reminders" if high-leverage

**New risk category:**
→ Add to Part B with severity level
→ Provide detection criteria
→ Include example

**New opportunity type:**
→ Add to Part C (REAL or PIE-IN-THE-SKY)
→ Specify validation criteria
→ Provide competitor example

**Process improvement:**
→ Update Workflow section
→ Add to Step 0 if it's a pre-evaluation check
→ Document in output format

**Clarification:**
→ Add to relevant section
→ Include edge case example
→ Update "Edge Cases" section if needed

### Step 4: Test the Update

**Before committing:**
1. **Re-run past evaluation** with updated skill
   - Would it have caught the gap?
   - Does it produce better output?
   - Are there unintended side effects?

2. **Check for over-fitting**
   - Would this help other deals or just this one?
   - Is it too specific?

3. **Validate examples**
   - Are examples accurate?
   - Do they clarify the instruction?

### Step 5: Version and Document

```bash
# Update version in SKILL.md frontmatter
---
name: deal-evaluator
version: 2.1
last_updated: 2026-02-XX
---

# Update README.md
## Version History
**v2.1** (2026-02-XX): [Brief description of change]
- [Specific update 1]
- [Specific update 2]

# Commit with detailed message
git add skills/deal-evaluator/
git commit -m "Update deal-evaluator: [Brief description]

Gap identified: [What was missed]
Example: [Deal name]
Solution: [What changed]

Impact: [How this improves evaluations]"

git push origin main
```

### Step 6: Re-upload to Claude Project

1. Download updated SKILL.md from GitHub
2. Go to claude.ai → "Deal Flow" project
3. Remove old SKILL.md from project knowledge
4. Upload new SKILL.md
5. Test with sample query to verify it works

## Update Examples

### Example 1: Adding Systematic Pricing Check

**Gap:** Missed 45-95% underpricing in SurveyPlanet  
**Root Cause:** Pricing investigation was optional, not automatic  
**Solution:** Made pricing check mandatory with specific triggers

**Change made:**
```markdown
**SYSTEMATIC PRICING CHECK (Always Evaluate First)**

For SEO/organic-driven businesses, pricing is often the #1 untapped lever. Check systematically:

1. **When was the last price increase?**
   - If >3 years ago: Automatic investigation trigger
   
2. **Research competitor pricing** (mandatory):
   - Document 3-5 competitors' pricing
   - Calculate gap
```

**Test:** Re-ran SurveyPlanet evaluation → correctly identified pricing opportunity

### Example 2: Adding P&L Interrogation

**Gap:** $234k "Outside Services" was unclear, changed SDE by 17 points  
**Root Cause:** Accepted P&L at face value, didn't flag unclear items  
**Solution:** Added Step 0 to interrogate before scoring

**Change made:**
```markdown
**STEP 0: Interrogate P&L Before Scoring**

Red flags requiring immediate clarification:
- Vague line items >$50k: "Outside Services," "Consulting"
- Multiple potential founder compensation categories

Action: List these items in "P&L Clarification Needed" section
```

**Test:** Would have flagged $234k immediately, generated Phase 1 question

## Common Anti-Patterns

### ❌ Anti-Pattern 1: Making Framework More Complex Without Reason
**Problem:** Adding nested sub-criteria, exceptions, special cases  
**Example:** "For deals in Q4 with declining revenue but..." (over-fitted)  
**Solution:** Keep it simple. If pattern appears in 3+ deals, then add.

### ❌ Anti-Pattern 2: Adding Vague Instructions
**Problem:** "Consider context" or "use judgment"  
**Example:** "Assess whether growth decline is concerning" (unclear)  
**Solution:** Provide decision tree or specific criteria

### ❌ Anti-Pattern 3: Instruction Without Example
**Problem:** Adding new concept without showing how to use it  
**Example:** "Check for technical debt" (what does this mean?)  
**Solution:** Always include concrete example

### ❌ Anti-Pattern 4: Ignoring Real-World Constraints
**Problem:** Asking for data that sellers never provide  
**Example:** "Get 5-year cohort analysis" (unrealistic)  
**Solution:** Focus on data that's actually available

### ❌ Anti-Pattern 5: Over-Automating Judgment Calls
**Problem:** Trying to encode every decision as rules  
**Example:** "If X AND Y AND Z, then exactly 7.3 points"  
**Solution:** Accept some judgment. Provide guidance, not formulas.

## Best Practices

### ✅ Use Concrete Examples
```markdown
# Bad
Consider whether pricing is competitive

# Good
Example: 
- Deal: $20/mo
- Competitor A: $35/mo (+75%)
- Competitor B: $50/mo (+150%)
→ REAL opportunity: 40-60% price increase
```

### ✅ Provide Decision Criteria
```markdown
# Bad
Assess founder dependency risk

# Good
Founder dependency indicators:
- Founder handles all customer support personally
- No documented processes
- Team tenure <6 months
If 2+ indicators present → HIGH risk
```

### ✅ Make Actions Explicit
```markdown
# Bad
Think about pricing

# Good
Action:
1. Search for 3-5 competitors
2. Document their pricing tiers
3. Calculate price gap
4. If >30% gap, flag as REAL opportunity
```

### ✅ Build on Past Learnings
```markdown
Example: SurveyPlanet never raised prices in 15 years
- Last increase: Never → Strong signal
- Competitors: 45-95% more expensive
- Result: +$252k ARR opportunity
```

## Maintenance Schedule

### After Each Evaluation (Immediate)
- Document gaps in `docs/learnings.md`
- Note if update is needed

### Weekly (If Active)
- Review week's evaluations
- Identify patterns
- Propose updates if patterns clear

### Monthly
- Review all learnings
- Decide which updates to make
- Make batch updates
- Re-upload to Claude project

### Quarterly
- Major framework review
- Validate all examples still relevant
- Check for outdated sections
- Consider architectural changes

## Quality Checklist

Before pushing any update, verify:

- [ ] Change is based on real evaluation gap
- [ ] Solution is minimum viable (not over-engineered)
- [ ] Instructions are clear and specific
- [ ] Examples are provided and accurate
- [ ] Would help future evaluations (not just this one)
- [ ] Re-tested on past evaluation (would it help?)
- [ ] Version number incremented
- [ ] Changelog updated
- [ ] Commit message is descriptive
- [ ] Re-uploaded to Claude project

## Deprecation Policy

Sometimes sections become obsolete. When removing content:

1. **Document why** in commit message
2. **Archive** removed content in `docs/deprecated/`
3. **Update version** as major if breaking change
4. **Test** that removal doesn't break evaluations

## Questions to Ask

**Before adding complexity:**
- Will this help 80% of evaluations or just this one edge case?
- Can we handle this with existing framework?
- Is this a pattern or a one-off?

**Before removing content:**
- Has this not been useful in 10+ evaluations?
- Is this pattern truly obsolete?
- Will removing this hurt evaluation quality?

**After any change:**
- Would this have improved past evaluations?
- Is this clearer than before?
- Can Claude execute this consistently?

## Related Documents

- [Learnings](./learnings.md) - Accumulated insights from evaluations
- [Future Architecture](./future-architecture.md) - Long-term evolution plan
- [Deal Evaluator Skill](../skills/deal-evaluator/SKILL.md) - Current framework
