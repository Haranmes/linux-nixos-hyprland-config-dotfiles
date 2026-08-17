function ai-branch
    git diff --staged | claude -p (cat ~/.config/claude-code/prompts/git-branch.md | string collect) | hx
end
