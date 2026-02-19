# Setup Guide: Deal Flow Review System

Complete step-by-step instructions to set up the hybrid skill + future agent architecture.

## Prerequisites

- [ ] GitHub account with access to https://github.com/noosalabs/deal-flow-review
- [ ] Git installed locally
- [ ] Claude.ai account
- [ ] (Optional) Claude Code for future agent work

## Phase 1: Initial Repository Setup

### Option A: Automated Setup (Recommended)

If you're running this from Claude with bash access:

```bash
# Run the setup script
chmod +x /tmp/deal-flow-repo-setup/scripts/setup-repo.sh
/tmp/deal-flow-repo-setup/scripts/setup-repo.sh
```

This will:
1. Clone the repository
2. Create directory structure
3. Copy all files
4. Make scripts executable
5. Create initial commit
6. Push to GitHub

### Option B: Manual Setup

If the script doesn't work or you prefer manual setup:

```bash
# 1. Clone the repository
cd ~/projects
git clone https://github.com/noosalabs/deal-flow-review.git
cd deal-flow-review

# 2. Create directory structure
mkdir -p skills/deal-evaluator
mkdir -p skills/memo-writer
mkdir -p agents
mkdir -p examples/{evalart,surveyplanet}
mkdir -p docs
mkdir -p scripts

# 3. Copy files (if available in /tmp/deal-flow-repo-setup)
cp -r /tmp/deal-flow-repo-setup/* .

# 4. Make scripts executable
chmod +x scripts/*.sh

# 5. Initial commit
git add .
git commit -m "Initial commit: Deal flow review framework"

# 6. Push to GitHub
git push -u origin main
```

## Phase 2: Upload Skill to Claude.ai

### Step 1: Create Claude Project

1. Go to https://claude.ai
2. Click "Projects" in left sidebar
3. Click "Create Project"
4. Name it: **"Deal Flow"**
5. Description: "Systematic evaluation of micro-SaaS acquisition opportunities"

### Step 2: Add Skill as Project Knowledge

1. In the "Deal Flow" project, click "Project knowledge"
2. Click "Add content"
3. Upload `skills/deal-evaluator/SKILL.md` from your local repository
4. The skill is now available to all conversations in this project

### Step 3: Test the Skill

1. Start a new chat in the "Deal Flow" project
2. Upload a sample deal document (or use a test prompt):
   ```
   Evaluate a hypothetical SaaS deal:
   - $400k ARR
   - Growing 15% YoY
   - 60% SDE margin
   - Self-serve product
   - Sells to SMBs
   - Asking price: $800k (2x ARR)
   ```
3. Claude should automatically invoke the skill and produce a structured evaluation

### Step 4: Verify Output Format

Check that Claude produces:
- ✅ Executive Summary
- ✅ Part A: Criteria Match (scored)
- ✅ Part B: Risk Assessment
- ✅ Part C: Growth Opportunities (REAL vs. PIE-IN-THE-SKY)
- ✅ Part D: Competitive Research
- ✅ Stack Ranking Score
- ✅ Recommendation (PURSUE/PASS)

## Phase 3: Workflow Integration

### Daily Usage

When you get a new deal:

1. **Open "Deal Flow" project** in claude.ai
2. **Upload deal documents:**
   - SIM (Seller Information Memorandum)
   - P&L (Profit & Loss statement)
   - Questions doc (if you've done founder Q&A)
   - Website screenshots
3. **Invoke evaluation:**
   ```
   Evaluate [Company Name]
   ```
4. **Discuss findings interactively:**
   - Ask clarifying questions
   - Explore specific risks
   - Model different scenarios
5. **If PURSUE → Generate memo:**
   ```
   Write an investment memo for this deal
   ```

### Document Reading Order

Claude will automatically follow this priority:
1. Questions doc (if exists) - read FIRST
2. P&L - for financials
3. SIM - for business description
4. Other documents

### Example Interaction

```
You: Here's SurveyPlanet [uploads SIM, P&L, questions.docx]

Claude: [reads questions doc first]
[identifies pricing opportunity, P&L clarifications needed]
[produces full evaluation]

Result: PURSUE - 68% composite score
- 3 REAL opportunities validated
- Pricing: +$252k ARR potential
- Email activation: +$100k ARR potential
```

## Phase 4: Skill Maintenance

### After Each Evaluation

1. **Document gaps** in `docs/learnings.md`:
   ```markdown
   ### [Company Name] - [Date]
   **Gap Identified:** [What framework missed]
   **Example:** [Specific situation]
   **Proposed Fix:** [How to address]
   ```

2. **Decide if update needed:**
   - Is this a pattern (3+ deals) or one-off?
   - Will this improve future evaluations?
   - Is it systematic or requires judgment?

### Making Updates

When you identify a framework improvement:

```bash
# 1. Edit the skill locally
cd ~/projects/deal-flow-review
code skills/deal-evaluator/SKILL.md

# 2. Update version and changelog
# In SKILL.md frontmatter: version: 2.1
# In README.md: Add version history entry

# 3. Test the change
# Re-run past evaluation mentally - would it help?

# 4. Commit and push
git add skills/deal-evaluator/
git commit -m "Update deal-evaluator: [brief description]

Gap: [what was missed]
Solution: [what changed]
Impact: [how this helps]"

git push origin main

# 5. Re-upload to Claude
# Go to claude.ai → Deal Flow project
# Remove old SKILL.md from project knowledge
# Upload updated SKILL.md
```

### Using the Sync Script

For quick updates after editing in Claude:

```bash
# Run the sync script
cd ~/projects/deal-flow-review
./scripts/sync-skills.sh

# This will:
# 1. Copy SKILL.md from Claude's skill directory
# 2. Check for changes
# 3. Prompt for commit message
# 4. Push to GitHub
# 5. Remind you to re-upload to claude.ai
```

## Phase 5: Future - Sub-Agent Setup (6-12 months)

When you're ready to migrate to autonomous agents:

### Prerequisites

- [ ] 20+ evaluations completed with skill
- [ ] Framework stable (<5% changes per month)
- [ ] Evaluating 5+ deals per week
- [ ] Claude Code installed and configured

### Agent Setup

```bash
# 1. Create agent directory
cd ~/projects/deal-flow-review
mkdir -p agents/deal-evaluator-agent

# 2. Create agent config
cat > agents/deal-evaluator-agent/config.json << 'EOF'
{
  "name": "deal-evaluator",
  "model": "claude-sonnet-4",
  "system_prompt_file": "../../skills/deal-evaluator/SKILL.md",
  "tools": ["web_search", "document_reader"],
  "max_tokens": 50000,
  "output_schema": "schemas/output.json"
}
EOF

# 3. Create schemas directory
mkdir -p agents/deal-evaluator-agent/schemas

# 4. Test agent
claude-code run deal-evaluator-agent \
  --input test-deal.json \
  --output evaluation.json
```

See `docs/future-architecture.md` for detailed agent setup instructions.

## Troubleshooting

### Issue: Skill not invoking in Claude project

**Solution:**
1. Check that SKILL.md is in project knowledge
2. Try explicitly saying "using the deal-evaluator skill"
3. Verify the skill file uploaded correctly (check file size)

### Issue: Sync script can't find Claude skills directory

**Solution:**
```bash
# Check if directory exists
ls /mnt/skills/user/deal-evaluator

# If not, you're not in Claude's bash environment
# Use manual sync: copy file from claude.ai and commit
```

### Issue: Git push rejected

**Solution:**
```bash
# Pull latest changes first
git pull origin main

# Resolve any conflicts
# Then push
git push origin main
```

### Issue: Skill produces inconsistent output

**Solution:**
1. Check that skill file is up to date in project
2. Remove and re-upload if necessary
3. Clear conversation and start fresh
4. If problem persists, open issue in GitHub

## Best Practices

### ✅ DO

- Upload all available documents (SIM, P&L, questions)
- Read questions doc if founders provided one
- Discuss findings before finalizing
- Document learnings after each evaluation
- Update skill when patterns emerge (3+ deals)
- Version control all changes
- Keep skill and repo in sync

### ❌ DON'T

- Skip uploading questions doc (critical data)
- Update skill based on single edge case
- Make complex changes without testing
- Forget to re-upload to Claude after updates
- Ignore gaps - document them even if not fixing yet

## Support

### Resources

- **Repository:** https://github.com/noosalabs/deal-flow-review
- **Skill Documentation:** `skills/deal-evaluator/README.md`
- **Learnings:** `docs/learnings.md`
- **Future Roadmap:** `docs/future-architecture.md`
- **Development Guide:** `docs/skill-development.md`

### Questions

If you have questions about:
- **Usage:** Review this guide and skill README
- **Updates:** See `docs/skill-development.md`
- **Future agents:** See `docs/future-architecture.md`
- **Past evaluations:** See `docs/learnings.md`

## Quick Reference

### Common Commands

```bash
# Clone repository
git clone https://github.com/noosalabs/deal-flow-review.git

# Navigate to repository
cd ~/projects/deal-flow-review

# Sync skills from Claude
./scripts/sync-skills.sh

# Pull latest changes
git pull origin main

# Push updates
git push origin main

# Check status
git status

# View commit history
git log --oneline

# Create new branch for major changes
git checkout -b feature/new-risk-category
```

### File Locations

- **Main skill:** `skills/deal-evaluator/SKILL.md`
- **Documentation:** `docs/`
- **Examples:** `examples/`
- **Scripts:** `scripts/`
- **Future agents:** `agents/` (when ready)

### Version Management

Current version: **v2.0** (February 13, 2026)

See `skills/deal-evaluator/README.md` for version history.

## Success Checklist

Setup is complete when:

- [ ] Repository cloned to `~/projects/deal-flow-review`
- [ ] All files in place (check with `ls -R`)
- [ ] Scripts are executable (`chmod +x scripts/*.sh`)
- [ ] Initial commit pushed to GitHub
- [ ] Claude project "Deal Flow" created
- [ ] SKILL.md uploaded to project knowledge
- [ ] Test evaluation produces expected output format
- [ ] You can edit skill, commit, push, and re-upload workflow
- [ ] Documentation reviewed and understood

**You're ready to start evaluating deals! 🎉**
