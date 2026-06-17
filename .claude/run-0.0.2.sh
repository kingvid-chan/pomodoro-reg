#!/bin/bash
cd /Users/cqw/外部需求/pomodoro-reg
PROMPT=$(cat .claude/task-0.0.2.txt)
PROMPT="$PROMPT

直接实施上述技术方案，不要再次确认。先读项目文件，修改 src/index.html，最后 git add + git commit 并报告自测完成。"

zsh -lic "claude -p '${PROMPT}' --permission-mode bypassPermissions --dangerously-skip-permissions --output-format json"
