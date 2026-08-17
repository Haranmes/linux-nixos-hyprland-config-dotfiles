function ai-spell
    vipe | claude -p (cat ~/.config/claude-code/prompts/improve-writing.md | string collect) | hx
end
