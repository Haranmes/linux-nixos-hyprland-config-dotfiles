function ai-email
    vipe | claude -p (cat ~/.config/claude-code/prompts/email-answer.md | string collect) | hx
end
