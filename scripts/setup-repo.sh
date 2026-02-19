#!/bin/bash

# setup-repo.sh
# Initial setup script for deal-flow-review repository

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}Deal Flow Review Repository Setup${NC}"
echo -e "${BLUE}========================================${NC}"
echo

# Step 1: Clone repository
echo -e "${YELLOW}Step 1: Cloning repository...${NC}"
cd ~/projects
if [ -d "deal-flow-review" ]; then
    echo "✓ Repository already cloned"
    cd deal-flow-review
else
    git clone https://github.com/noosalabs/deal-flow-review.git
    cd deal-flow-review
    echo -e "${GREEN}✓ Repository cloned${NC}"
fi
echo

# Step 2: Create directory structure
echo -e "${YELLOW}Step 2: Creating directory structure...${NC}"
mkdir -p skills/deal-evaluator
mkdir -p skills/memo-writer
mkdir -p agents
mkdir -p examples/evalart
mkdir -p examples/surveyplanet
mkdir -p docs
mkdir -p scripts
echo -e "${GREEN}✓ Directory structure created${NC}"
echo

# Step 3: Copy files from temporary setup
echo -e "${YELLOW}Step 3: Setting up initial files...${NC}"

# Check if running from Claude context
if [ -d "/tmp/deal-flow-repo-setup" ]; then
    echo "Copying files from Claude setup..."
    cp -r /tmp/deal-flow-repo-setup/* .
    echo -e "${GREEN}✓ Files copied${NC}"
else
    echo -e "${YELLOW}⚠️  Running outside Claude context${NC}"
    echo "Please manually copy files from setup directory"
fi
echo

# Step 4: Make scripts executable
echo -e "${YELLOW}Step 4: Making scripts executable...${NC}"
chmod +x scripts/*.sh
echo -e "${GREEN}✓ Scripts are now executable${NC}"
echo

# Step 5: Initial git setup
echo -e "${YELLOW}Step 5: Setting up git...${NC}"

# Check if this is a fresh repo
if [ -z "$(git log 2>/dev/null)" ]; then
    echo "Fresh repository detected, creating initial commit..."
    
    git add .
    git commit -m "Initial commit: Deal flow review framework

- Add deal-evaluator skill (v2.0)
- Add documentation structure
- Add future architecture plan
- Add learnings tracker
- Add sync scripts

Framework includes:
- Systematic pricing opportunity checks
- P&L interrogation before scoring
- Context-based growth assessment  
- Customer economics validation
- Document reading priority"
    
    echo -e "${GREEN}✓ Initial commit created${NC}"
else
    echo "Repository already has commits"
fi
echo

# Step 6: Push to GitHub
echo -e "${YELLOW}Step 6: Pushing to GitHub...${NC}"
read -p "Push to GitHub now? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    git push -u origin main
    echo -e "${GREEN}✓ Pushed to GitHub${NC}"
else
    echo -e "${YELLOW}⚠️  Skipped push. Run 'git push -u origin main' when ready${NC}"
fi
echo

# Step 7: Next steps
echo -e "${BLUE}========================================${NC}"
echo -e "${GREEN}✅ Setup complete!${NC}"
echo -e "${BLUE}========================================${NC}"
echo
echo "Next steps:"
echo
echo "1. Upload skill to Claude.ai:"
echo "   • Go to claude.ai"
echo "   • Create a project named 'Deal Flow'"
echo "   • Upload skills/deal-evaluator/SKILL.md to project knowledge"
echo
echo "2. Test the skill:"
echo "   • Upload a deal document (SIM, P&L)"
echo "   • Say: 'Evaluate this deal using the deal-evaluator skill'"
echo
echo "3. After making improvements:"
echo "   • Edit skills/deal-evaluator/SKILL.md"
echo "   • Run: ./scripts/sync-skills.sh"
echo "   • Re-upload updated SKILL.md to Claude project"
echo
echo "4. View documentation:"
echo "   • docs/future-architecture.md - Long-term evolution plan"
echo "   • docs/learnings.md - Accumulated insights"
echo "   • docs/skill-development.md - How to improve framework"
echo
echo "Repository: https://github.com/noosalabs/deal-flow-review"
echo
