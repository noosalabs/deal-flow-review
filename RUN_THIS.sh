#!/bin/bash

# RUN_THIS.sh
# Single command to set up entire deal-flow-review repository
# Usage: bash RUN_THIS.sh

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

clear

echo -e "${BLUE}"
cat << "EOF"
╔═══════════════════════════════════════════════════════════╗
║                                                           ║
║       Deal Flow Review Repository Setup                  ║
║       ================================                     ║
║                                                           ║
║       Setting up hybrid skill + agent architecture       ║
║                                                           ║
╚═══════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"
echo

# Confirm we're ready
echo -e "${YELLOW}This script will:${NC}"
echo "  1. Clone noosalabs/deal-flow-review repository"
echo "  2. Create complete directory structure"
echo "  3. Copy all skills and documentation"
echo "  4. Make scripts executable"
echo "  5. Create initial commit"
echo "  6. Push to GitHub"
echo
read -p "Continue? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 1
fi

echo

# Check if we have the source files
if [ ! -d "/tmp/deal-flow-repo-setup" ]; then
    echo -e "${YELLOW}⚠️  Source files not found at /tmp/deal-flow-repo-setup${NC}"
    echo "This script should be run from Claude with bash access."
    echo
    echo "Alternative: Follow SETUP_GUIDE.md for manual setup"
    exit 1
fi

# 1. Clone repository
echo -e "${BLUE}[1/6] Cloning repository...${NC}"
cd ~
mkdir -p projects
cd projects

if [ -d "deal-flow-review" ]; then
    echo "  Repository already exists at ~/projects/deal-flow-review"
    cd deal-flow-review
    
    # Check if it's the right repo
    if git remote get-url origin | grep -q "noosalabs/deal-flow-review"; then
        echo -e "${GREEN}  ✓ Correct repository${NC}"
    else
        echo -e "${YELLOW}  ⚠️  Existing directory is not the correct repository${NC}"
        exit 1
    fi
else
    git clone https://github.com/noosalabs/deal-flow-review.git
    cd deal-flow-review
    echo -e "${GREEN}  ✓ Repository cloned${NC}"
fi
echo

# 2. Create directory structure
echo -e "${BLUE}[2/6] Creating directory structure...${NC}"
mkdir -p skills/deal-evaluator skills/memo-writer
mkdir -p agents
mkdir -p examples/evalart examples/surveyplanet
mkdir -p docs
mkdir -p scripts
echo -e "${GREEN}  ✓ Directories created${NC}"
echo

# 3. Copy all files
echo -e "${BLUE}[3/6] Copying files...${NC}"
cp -r /tmp/deal-flow-repo-setup/* .
echo -e "${GREEN}  ✓ Files copied${NC}"
echo

# 4. Make scripts executable
echo -e "${BLUE}[4/6] Making scripts executable...${NC}"
chmod +x scripts/*.sh
echo -e "${GREEN}  ✓ Scripts executable${NC}"
echo

# 5. Create initial commit (if needed)
echo -e "${BLUE}[5/6] Creating git commit...${NC}"
if git rev-parse HEAD >/dev/null 2>&1; then
    # Repository has commits
    echo "  Repository already has commits"
    
    # Check if we have changes
    if [[ -n $(git status -s) ]]; then
        echo "  New changes detected:"
        git status -s | head -10
        echo
        read -p "  Commit these changes? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            git add .
            git commit -m "Setup: Add deal-evaluator skill v2.0 and documentation

- Add systematic pricing checks
- Add P&L interrogation framework
- Add context-based growth assessment
- Add comprehensive documentation
- Add sync scripts"
            echo -e "${GREEN}  ✓ Changes committed${NC}"
        fi
    else
        echo -e "${GREEN}  ✓ No changes to commit${NC}"
    fi
else
    # Fresh repository
    git add .
    git commit -m "Initial commit: Deal flow review framework v2.0

Complete framework setup:
- Deal evaluator skill with v2.0 improvements
- Comprehensive documentation
- Sync scripts and automation
- Future architecture plan

Key features:
- Systematic pricing opportunity checks  
- P&L interrogation before scoring
- Context-based growth assessment
- Customer economics validation
- Document reading priority (questions first)
- Enhanced SDE achievability modeling"
    
    echo -e "${GREEN}  ✓ Initial commit created${NC}"
fi
echo

# 6. Push to GitHub
echo -e "${BLUE}[6/6] Pushing to GitHub...${NC}"
read -p "  Push to GitHub now? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if git push -u origin main 2>/dev/null; then
        echo -e "${GREEN}  ✓ Pushed to GitHub${NC}"
    else
        # Try without -u flag (in case already tracking)
        git push origin main
        echo -e "${GREEN}  ✓ Pushed to GitHub${NC}"
    fi
else
    echo -e "${YELLOW}  ⚠️  Skipped push${NC}"
    echo "  Run this later: git push -u origin main"
fi
echo

# Success!
echo -e "${GREEN}"
cat << "EOF"
╔═══════════════════════════════════════════════════════════╗
║                                                           ║
║                   ✅  SETUP COMPLETE!                     ║
║                                                           ║
╚═══════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"
echo
echo -e "${BLUE}Next Steps:${NC}"
echo
echo "📋 1. Upload Skill to Claude.ai"
echo "   • Go to claude.ai"
echo "   • Create project: 'Deal Flow'"
echo "   • Upload: skills/deal-evaluator/SKILL.md"
echo
echo "🧪 2. Test the Skill"
echo "   • Upload a deal document (SIM, P&L)"
echo "   • Say: 'Evaluate this deal'"
echo
echo "📚 3. Read Documentation"
echo "   • SETUP_GUIDE.md - Complete usage guide"
echo "   • docs/future-architecture.md - Long-term plan"
echo "   • docs/learnings.md - Accumulated insights"
echo
echo "🔄 4. After Making Updates"
echo "   • Edit: skills/deal-evaluator/SKILL.md"
echo "   • Run: ./scripts/sync-skills.sh"
echo "   • Re-upload to claude.ai"
echo
echo -e "${GREEN}Repository location: ~/projects/deal-flow-review${NC}"
echo -e "${GREEN}GitHub: https://github.com/noosalabs/deal-flow-review${NC}"
echo
echo "Happy deal evaluating! 🚀"
echo
