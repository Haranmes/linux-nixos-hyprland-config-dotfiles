function ai-commit
    git diff --staged | claude -p (cat ~/.config/claude-code/prompts/commit-message.md | string collect) | hx
end
