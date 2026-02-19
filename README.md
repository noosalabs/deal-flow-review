# Deal Flow Review System

Systematic evaluation framework for micro-SaaS acquisition opportunities at Noosa Labs.

## Overview

This repository contains skills, agent configurations, and documentation for evaluating and documenting acquisition opportunities.

**Investment Thesis:**
- ARR: >$200k (SDE must be <$700k for affordability)
- Growth: >10% YoY (or explainable decline with recovery path)
- SDE: >50% (or achievable through optimization)
- Business Model: Product-led growth
- Customer Base: Primarily small businesses

## Repository Structure

```
deal-flow-review/
├── skills/                      # Claude skills for interactive use
│   ├── deal-evaluator/         # Systematic deal evaluation
│   └── memo-writer/            # Investment memo generation (coming soon)
├── agents/                      # Claude Code agent configs for automation
│   └── deal-evaluator-agent/   # Autonomous evaluation agent (future)
├── examples/                    # Real evaluation examples
│   ├── evalart/                # Example: Evalart acquisition
│   └── surveyplanet/           # Example: SurveyPlanet evaluation
├── docs/                        # Documentation and learnings
│   ├── skill-development.md    # How to improve skills
│   ├── learnings.md            # Accumulated insights
│   └── future-architecture.md  # Sub-agent roadmap
└── scripts/                     # Utility scripts
    └── sync-skills.sh          # Sync from Claude to GitHub
```

## Current Phase: Interactive Skills

**Status:** Using skills in Claude.ai projects for interactive evaluation.

### How to Use

1. **In Claude.ai:**
   - Create a "Deal Flow" project
   - Upload `skills/deal-evaluator/SKILL.md` as a project knowledge file
   - Upload deal documents (SIM, P&L, questions doc)
   - Invoke: "Evaluate [company name] using the deal-evaluator skill"

2. **Development Workflow:**
   - Edit skills in this repo
   - Commit changes with learnings documented
   - Re-upload updated skill to Claude project

## Future Phase: Sub-Agent Automation

**Planned:** Convert to Claude Code agents for batch processing and automation.

See `docs/future-architecture.md` for detailed roadmap.

## Skills

### [Deal Evaluator](./skills/deal-evaluator/)

Comprehensive evaluation framework covering:
- Criteria matching (5-point checklist)
- Risk flag detection (platform dependencies, AI displacement)
- Growth opportunity assessment (REAL vs. PIE-IN-THE-SKY)
- Competitive research
- Customer economics validation
- Stack ranking methodology

**Last Updated:** 2026-02-13 (v2.0)
- Added systematic pricing opportunity checks
- Added P&L interrogation framework
- Added context-based growth assessment
- Enhanced SDE achievability modeling

### Memo Writer (Coming Soon)

Investment memo generation using Evalart template structure.

## Examples

- [Evalart Evaluation](./examples/evalart/) - Successful acquisition, full evaluation + memo
- [SurveyPlanet Evaluation](./examples/surveyplanet/) - PURSUE recommendation with validation

## Contributing

This is an internal Noosa Labs repository. Updates come from:
1. Real deal evaluations (learnings captured)
2. Process improvements (documented in docs/learnings.md)
3. Edge cases discovered (updated in skills)

## Version History

- **v2.0** (2026-02-13): Major update based on SurveyPlanet evaluation
  - Systematic pricing checks
  - P&L interrogation
  - Context-based growth assessment
  
- **v1.0** (2023-XX-XX): Initial framework based on Evalart acquisition

## License

Private - Noosa Labs Internal Use Only
