function ai-linkedin
    vipe | claude -p (cat ~/.config/claude-code/prompts/linkedin-answer.md | string collect) | hx
end
