# Future Architecture: Sub-Agent Evolution

## Vision

Evolve from interactive skills to autonomous sub-agents for batch processing and automation.

## Current State (Phase 1: Interactive Skills)

**Architecture:**
```
User → Claude.ai (with skill context) → Evaluation Output
```

**Characteristics:**
- Single conversation context
- Interactive, can ask clarifying questions
- Flexible, adapts to edge cases
- User sees reasoning step-by-step
- ~35K tokens of context per evaluation

**Use Cases:**
- Complex deals requiring judgment
- Learning/iterating on evaluation process
- One-off evaluations with discussion
- 1-2 deals per week

## Target State (Phase 2: Sub-Agent Automation)

**Architecture:**
```
Main Orchestrator Agent
├── Deal Evaluator Agent (autonomous)
│   ├── Web search tool
│   ├── Document parser
│   └── Returns: Evaluation report
├── Memo Writer Agent (autonomous)
│   ├── Evaluation as input
│   └── Returns: Investment memo
└── Question Generator Agent (autonomous)
    └── Returns: Phase 2/3 questions
```

**Characteristics:**
- Separate context windows
- Autonomous, no mid-evaluation interruption
- Consistent, follows instructions precisely
- Returns structured output only
- Can run multiple in parallel

**Use Cases:**
- Batch evaluations (5+ deals at once)
- Automated filtering (Acquire.com scraper → evaluator)
- Deal flow dashboard
- 5+ deals per week

## Migration Path

### Milestone 1: Stabilize Framework (Current)
**Goal:** 20+ evaluations to validate framework

**Activities:**
- Use skill interactively in Claude.ai
- Document edge cases and improvements
- Build evaluation examples library
- Accumulate learnings

**Success Criteria:**
- <10% framework changes per evaluation
- Clear heuristics for all common scenarios
- Examples cover most deal types

### Milestone 2: Structure Output Format (3-6 months)
**Goal:** Standardize evaluation output for programmatic use

**Activities:**
- Define JSON schema for evaluation output
- Add structured sections (scores, flags, opportunities)
- Test parsing/validation
- Build example dataset

**Output Schema Example:**
```json
{
  "company": "SurveyPlanet",
  "recommendation": "PURSUE",
  "composite_score": 0.68,
  "criteria_match": {
    "arr_in_range": true,
    "growth_rate": false,
    "sde_achievable": true,
    "product_led": true,
    "smb_focus": true,
    "score": 4
  },
  "risk_flags": {
    "critical": [],
    "high": ["ai_displacement"],
    "medium": ["declining_mrr"]
  },
  "growth_opportunities": {
    "real": [
      {
        "type": "pricing",
        "impact_arr": 252000,
        "confidence": "high",
        "evidence": "Competitors 45-95% more expensive"
      }
    ],
    "pie_in_sky": []
  }
}
```

### Milestone 3: Build Agent Configuration (6-12 months)
**Goal:** Convert skill to Claude Code agent

**Activities:**
- Create agent system prompt from SKILL.md
- Configure tools (web search, document parsing)
- Build invocation interface
- Test autonomous operation

**Agent Config Example:**
```json
{
  "name": "deal-evaluator",
  "model": "claude-sonnet-4",
  "system_prompt": "[SKILL.md content]",
  "tools": [
    "web_search",
    "document_reader",
    "calculator"
  ],
  "output_schema": "evaluation_schema_v1.json",
  "max_tokens": 50000
}
```

### Milestone 4: Build Orchestration (12-18 months)
**Goal:** Multi-agent workflow automation

**Activities:**
- Build orchestrator agent
- Connect to data sources (Acquire.com, email)
- Build deal flow dashboard
- Implement batch processing

**Workflow Example:**
```python
# Pseudo-code for automated deal flow
deals = acquire_scraper.get_starred_deals()

for deal in deals:
    # Download documents
    docs = download_deal_docs(deal)
    
    # Call evaluator agent
    evaluation = evaluator_agent.evaluate(docs)
    
    # If PURSUE, generate memo
    if evaluation.recommendation == "PURSUE":
        memo = memo_writer_agent.write(evaluation)
        send_notification(deal, evaluation, memo)
    else:
        log_pass_reason(deal, evaluation)

# Daily digest
send_digest(top_3_deals)
```

## Decision Points

### When to Migrate from Skill to Agent?

**Evaluate these signals:**

1. **Volume:** Are you evaluating 5+ deals per week consistently?
2. **Stability:** Is the framework stable (<5% changes per month)?
3. **Patterns:** Are 80%+ of evaluations straightforward (no edge cases)?
4. **Automation:** Do you want to process deals without manual intervention?
5. **Parallel:** Do you need to evaluate multiple deals simultaneously?

**If 4+ signals are YES → Migrate to agent**

### Hybrid Approach (Recommended)

Keep both skill AND agent:

**Use Skill for:**
- Complex/unusual deals
- Learning from edge cases
- Interactive discussion with stakeholders
- Quarterly framework reviews

**Use Agent for:**
- Standard evaluations
- Batch processing
- Initial filtering
- Automated scoring

## Technical Implementation

### Agent Setup via Claude Code

**Directory Structure:**
```
agents/
└── deal-evaluator-agent/
    ├── config.json
    ├── system_prompt.txt (from SKILL.md)
    ├── tools/
    │   ├── web_search.py
    │   ├── competitor_research.py
    │   └── document_parser.py
    ├── schemas/
    │   ├── input_schema.json
    │   └── output_schema.json
    └── tests/
        ├── test_evalart.py
        └── test_surveyplanet.py
```

**Invocation Methods:**

1. **CLI:**
```bash
claude-code run deal-evaluator \
  --sim path/to/sim.pdf \
  --pnl path/to/pnl.xlsx \
  --questions path/to/questions.docx
```

2. **Python API:**
```python
from claude_code import Agent

evaluator = Agent.load('deal-evaluator-agent')
result = evaluator.run({
    'sim': 'path/to/sim.pdf',
    'pnl': 'path/to/pnl.xlsx'
})
print(result.recommendation)  # PURSUE or PASS
```

3. **MCP Server (for other agents):**
```json
{
  "mcpServers": {
    "deal-evaluator": {
      "command": "npx",
      "args": ["-y", "@noosalabs/deal-evaluator-mcp"]
    }
  }
}
```

## Risks & Mitigations

### Risk: Agent misses edge cases that skill would catch
**Mitigation:** 
- Always review agent output before acting
- Keep skill for complex deals
- Build confidence gradually (start with low-stakes evaluations)

### Risk: Framework ossifies, stops learning
**Mitigation:**
- Quarterly skill reviews incorporating agent learnings
- Keep feedback loop: Agent results → Skill improvements → Agent updates
- Document "agent failures" to improve system prompt

### Risk: Over-automation reduces judgment quality
**Mitigation:**
- Agent produces recommendations, not decisions
- Human always makes final PURSUE/PASS call
- Agent flags "high uncertainty" for human review

## Success Metrics

### Phase 1 (Current - Interactive Skill)
- ✅ Skill used for 20+ evaluations
- ✅ <10% framework changes per evaluation
- ✅ All PURSUE deals have structured output

### Phase 2 (Structured Output)
- JSON schema validated on all evaluations
- Can reconstruct evaluation from JSON alone
- Scores are deterministic (same inputs → same scores)

### Phase 3 (Agent Launch)
- Agent evaluations match skill evaluations 90%+ of time
- Agent processing time <10 minutes per deal
- Zero critical bugs in first 20 agent evaluations

### Phase 4 (Automation)
- Process 20+ deals per week autonomously
- Human review time <15 minutes per deal
- <5% agent recommendations overturned by human

## Timeline Estimate

- **Now - Month 6:** Phase 1 (Interactive skill, accumulate learnings)
- **Month 6-12:** Phase 2 (Structured output, JSON schema)
- **Month 12-18:** Phase 3 (Agent build, testing)
- **Month 18-24:** Phase 4 (Orchestration, automation)

**Note:** Timeline depends on deal volume. Higher volume accelerates migration.

## Open Questions

1. How to handle deals requiring external research (customer calls, founder references)?
2. Should agent have ability to "pause and ask human" for ambiguous situations?
3. How to version agent alongside skill (keep in sync)?
4. What's the rollback plan if agent quality degrades?
5. How to A/B test agent vs. skill evaluations?

## Related Documents

- [Skill Development Guide](./skill-development.md)
- [Learnings from Evaluations](./learnings.md)
- [Deal Evaluator Skill](../skills/deal-evaluator/SKILL.md)
