# 迭代 0.0.1 — 番茄钟计时器

## 技术方案

纯静态单页面，HTML + CSS + JavaScript，零依赖。

### 架构
- 单文件 `src/index.html`：内嵌 CSS 和 JS
- 无后端，无框架
- basePath `/projects/pomodoro-reg/` 适配

### 组件
1. **倒计时显示**：大号数字 MM:SS，从 25:00 开始
2. **控制按钮**：开始、暂停、重置
3. **归零高亮**：倒计时到 00:00 时添加 `.finished` class，触发视觉变化

### 状态机
```
IDLE → RUNNING (开始)
RUNNING → PAUSED (暂停)
PAUSED → RUNNING (开始/继续)
RUNNING → FINISHED (归零)
FINISHED → IDLE (重置)
PAUSED → IDLE (重置)
```

### 数据边界
- 不使用 localStorage/cookie/sessionStorage
- 不收集任何数据
- 纯内存状态

## 任务拆解
- [x] 创建 iteration/0.0.1 分支
- [ ] 编写迭代计划
- [ ] 实现 src/index.html
- [ ] 自测
- [ ] 更新文档
- [ ] 提交
