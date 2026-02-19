# Repository Structure

Complete file tree for deal-flow-review repository:

```
deal-flow-review/
│
├── README.md                           # Main repository overview
├── SETUP_GUIDE.md                      # Complete setup instructions
├── .gitignore                          # Git ignore rules
│
├── skills/                             # Claude skills for interactive use
│   ├── deal-evaluator/
│   │   ├── SKILL.md                   # Main skill file (v2.0)
│   │   └── README.md                  # Skill documentation
│   │
│   └── memo-writer/                   # Future: Investment memo generation
│       └── (coming soon)
│
├── agents/                             # Future: Claude Code agent configs
│   └── deal-evaluator-agent/
│       └── (phase 2 - not yet implemented)
│
├── examples/                           # Real evaluation examples
│   ├── evalart/
│   │   └── (add Evalart evaluation memo)
│   │
│   └── surveyplanet/
│       └── (add SurveyPlanet evaluation)
│
├── docs/                               # Documentation
│   ├── future-architecture.md         # Sub-agent evolution roadmap
│   ├── learnings.md                   # Accumulated insights from deals
│   └── skill-development.md           # How to improve the framework
│
└── scripts/                            # Utility scripts
    ├── setup-repo.sh                  # Initial setup automation
    └── sync-skills.sh                 # Sync skills from Claude to GitHub

```

## Key Files

### Production Files (Use These)
- `skills/deal-evaluator/SKILL.md` - Upload to Claude.ai project
- `SETUP_GUIDE.md` - Follow this for setup
- `scripts/sync-skills.sh` - Run after editing skills

### Documentation (Read These)
- `README.md` - Repository overview
- `skills/deal-evaluator/README.md` - Skill documentation
- `docs/future-architecture.md` - Long-term vision
- `docs/learnings.md` - Pattern recognition from deals
- `docs/skill-development.md` - How to improve framework

### Future (Not Yet Used)
- `agents/` - Sub-agent configurations (Phase 2)
- `examples/` - Populate with real evaluations

## File Sizes

- SKILL.md: ~31KB (main evaluation framework)
- All docs: ~80KB total
- Complete repo: ~150KB (very lightweight)

## Next Steps

1. Run `scripts/setup-repo.sh` to initialize
2. Upload `skills/deal-evaluator/SKILL.md` to claude.ai
3. Start evaluating deals!
