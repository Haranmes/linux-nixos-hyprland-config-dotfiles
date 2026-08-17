function ai-emoji-commit
    git diff --staged | claude -p (cat ~/.config/claude-code/prompts/emoji-commit-message.md | string collect) | hx
end
