# 迭代 0.0.1 — 番茄钟计时器

## 技术方案

纯静态单页面，HTML + CSS + JavaScript，零依赖、无框架、无后端。

### 架构

- 单文件 `src/index.html`：内嵌 `<style>` 和 `<script>`，完全自包含
- 无构建工具、无 npm、无 CDN 外部资源
- 基路径 `/projects/pomodoro-reg/` 适配（用于服务器子路径部署）

### 组件

1. **倒计时显示** `<div id="timer">`：大号数字 MM:SS，初始值 `25:00`
2. **控制按钮** `<button>`：
   - **开始** (id="btn-start")：启动倒计时 → RUNNING
   - **暂停** (id="btn-pause")：暂停倒计时 → PAUSED
   - **重置** (id="btn-reset")：重置到 25:00 → IDLE
3. **归零高亮**：倒计时到 `00:00` 时 `<body>` 添加 `.finished` class
   - 背景色切换为绿色
   - 计时器文字变大、加粗
   - 所有按钮高亮边框变化

### 状态机

```
IDLE → RUNNING (点击"开始")
RUNNING → PAUSED (点击"暂停")
PAUSED → RUNNING (点击"开始"/"继续")
RUNNING → FINISHED (倒计时归零 → 00:00)
FINISHED → IDLE (点击"重置")
PAUSED → IDLE (点击"重置")
```

状态枚举：`IDLE | RUNNING | PAUSED | FINISHED`

### 核心逻辑

- 使用 `setInterval` 每秒递减 `remainingSeconds`
- `remainingSeconds` 初始值 = 1500 (25 × 60)
- 每秒更新显示 `MM:SS` 格式
- 归零时清除 interval，切换状态为 FINISHED，触发高亮
- 暂停时清除 interval，保留 `remainingSeconds`

### 数据边界

- 不使用 localStorage、cookie、sessionStorage
- 不收集任何用户数据
- 无登录/注册
- 无音效通知
- 无历史记录或统计
- 无移动端适配
- 不可自定义时长（固定 25 分钟）
- 纯内存状态，刷新即丢失

### 验收标准

- 倒计时数字从 25:00 开始逐秒递减
- 归零（00:00）时页面背景变绿、计时器文字变大加粗
- 开始/暂停/重置按钮功能正确，状态切换无异常
- 静态资源 URL 带版本令牌 `?v=0.0.1`，路径前缀 `/projects/pomodoro-reg/`
- 文档 HTTP 响应头含 `Cache-Control: no-cache`（部署时 Nginx/Flask 中间件实现）

### 风险与缓解

| 风险 | 缓解 |
|------|------|
| setInterval 时间漂移 | 单页面无需精确计时，1 秒精度可接受 |
| 浏览器 tab 后台时 timer 降频 | 使用实际时间戳差值补偿（可选方案，当前不实现） |
| basePath 下资源路径错误 | 纯内嵌无外部资源，basePath 仅影响服务器路由配置 |

## 任务拆解

- [x] 创建 iteration/0.0.1 分支
- [x] 编写迭代计划
- [ ] 实现 src/index.html（番茄钟完整实现）
- [ ] 本地 Python http.server 自测
- [ ] 保存自测输出到 evidence/claude/self-test-0.0.1.txt
- [ ] 更新 docs/architecture.md 和 docs/runbook.md
- [ ] 提交所有变更（小步 commit）
