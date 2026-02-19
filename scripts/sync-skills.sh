#!/bin/bash

# sync-skills.sh
# Syncs skills from Claude's skill directory to GitHub repository

set -e  # Exit on error

# Configuration
CLAUDE_SKILLS_DIR="/mnt/skills/user"
REPO_DIR="$HOME/projects/deal-flow-review"
SKILLS_DIR="$REPO_DIR/skills"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo "🔄 Syncing skills from Claude to GitHub..."
echo

# Check if repo directory exists
if [ ! -d "$REPO_DIR" ]; then
    echo -e "${RED}Error: Repository directory not found at $REPO_DIR${NC}"
    echo "Please clone the repository first:"
    echo "  git clone https://github.com/noosalabs/deal-flow-review.git ~/projects/deal-flow-review"
    exit 1
fi

# Create skills directory if it doesn't exist
mkdir -p "$SKILLS_DIR"

# Function to sync a skill
sync_skill() {
    local skill_name=$1
    local source_dir="$CLAUDE_SKILLS_DIR/$skill_name"
    local target_dir="$SKILLS_DIR/$skill_name"
    
    if [ ! -d "$source_dir" ]; then
        echo -e "${YELLOW}⚠️  Skill '$skill_name' not found in Claude directory${NC}"
        return 1
    fi
    
    echo "📝 Syncing $skill_name..."
    
    # Create target directory
    mkdir -p "$target_dir"
    
    # Copy SKILL.md
    if [ -f "$source_dir/SKILL.md" ]; then
        cp "$source_dir/SKILL.md" "$target_dir/"
        echo -e "${GREEN}   ✓ Copied SKILL.md${NC}"
    else
        echo -e "${RED}   ✗ SKILL.md not found${NC}"
        return 1
    fi
    
    # Copy any other files (README, examples, etc.)
    for file in "$source_dir"/*; do
        if [ -f "$file" ] && [ "$(basename "$file")" != "SKILL.md" ]; then
            cp "$file" "$target_dir/"
            echo -e "${GREEN}   ✓ Copied $(basename "$file")${NC}"
        fi
    done
    
    return 0
}

# Sync deal-evaluator
sync_skill "deal-evaluator"

# Sync memo-writer if it exists
if [ -d "$CLAUDE_SKILLS_DIR/memo-writer" ]; then
    sync_skill "memo-writer"
fi

echo
echo "📂 Checking for changes..."

# Navigate to repo
cd "$REPO_DIR"

# Check if there are changes
if [[ -n $(git status -s) ]]; then
    echo -e "${YELLOW}Changes detected:${NC}"
    git status -s
    echo
    
    # Prompt for commit message
    read -p "Enter commit message (or press Enter for default): " commit_msg
    
    if [ -z "$commit_msg" ]; then
        commit_msg="Update skills from Claude - $(date +%Y-%m-%d)"
    fi
    
    # Stage changes
    git add skills/
    
    # Commit
    git commit -m "$commit_msg"
    
    # Push
    echo
    read -p "Push to GitHub? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git push origin main
        echo -e "${GREEN}✅ Skills synced to GitHub successfully!${NC}"
    else
        echo -e "${YELLOW}⚠️  Changes committed locally but not pushed${NC}"
        echo "Run 'git push origin main' when ready"
    fi
else
    echo -e "${GREEN}✓ No changes to sync${NC}"
fi

echo
echo "Done! 🎉"
