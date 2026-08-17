function claude_fish
    set -l _old (commandline)
    if test -n "$_old"
        echo -n "⌛"
        commandline -f repaint
        commandline (claude -p "Convert the following into a single shell command. Output ONLY the raw command, no explanation, no markdown/code fences: $_old" | string collect | string trim)
    end
end
