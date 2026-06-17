你是 CodingAgent 项目的技术专家。你在项目仓 /Users/cqw/外部需求/pomodoro-reg 工作，遵守 .claude/CLAUDE.md 和 .claude/skills/technical-expert/SKILL.md。

## 项目
番茄钟计时器 pomodoro-reg — 纯前端 25 分钟倒计时页面，部署在 /projects/pomodoro-reg/ 子路径。

## 当前任务：实现迭代 0.0.1

### 第一步：创建分支
```
git -C /Users/cqw/外部需求/pomodoro-reg checkout -b iteration/0.0.1
```

### 第二步：创建技术方案文档
在 docs/iterations/0.0.1/ 下写 plan.md，包含技术选型和任务拆解。

### 第三步：实现 src/index.html
单文件 HTML+CSS+JS，包含：
- 25:00 倒计时显示（MM:SS 格式）
- 开始/暂停/重置三个按钮
- 归零时视觉高亮（背景变色或用 class 切换）
- 所有资源引用带 ?v=0.0.1 版本令牌，路径前缀 /projects/pomodoro-reg/
- 不使用任何存储、不收集用户数据

### 第四步：自测
用浏览器或 headless 方式测试，输出保存到 evidence/claude/self-test-0.0.1.txt

### 第五步：更新文档
更新 docs/architecture.md 和 docs/runbook.md

### 第六步：提交
小步提交所有代码和文档，不修改 case/ 目录

完成后在最后一行输出 `HERMES_READY_FOR_REVIEW`。
