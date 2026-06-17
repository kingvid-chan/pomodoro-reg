# Architecture — 番茄钟计时器 (pomodoro-reg)

## 概述

纯前端番茄钟计时器，25 分钟固定倒计时，面向桌面浏览器。

## 技术栈

- **前端**：HTML5 + CSS3 + Vanilla JavaScript（单文件，零依赖）
- **部署**：Nginx 静态服务，子路径 `/projects/pomodoro-reg/`
- **运行时**：浏览器，无 Node.js/构建工具

## 组件

### src/index.html
自包含的单页面应用：
- CSS 样式内嵌在 `<style>` 标签
- JavaScript 逻辑内嵌在 `<script>` 标签
- `<base href="/projects/pomodoro-reg/">` 确保资源路径正确

### 状态机
```
IDLE → (点击"开始") → RUNNING → (归零) → FINISHED
RUNNING → (点击"暂停") → PAUSED
PAUSED → (点击"继续") → RUNNING
任意状态 → (点击"重置") → IDLE
```

### 视觉反馈
- FINISHED 状态：body 添加 `.finished` class
  - 背景从深蓝 #1a1a2e 过渡到深绿 #0d4f1e
  - 计时器文字从白色渐变到绿色 #00ff88
  - 标题颜色变为 #80ffb0

## 数据流

无持久化、无网络请求、无用户数据收集。
所有状态存于 JavaScript 内存变量。

## 部署

参见 [runbook.md](runbook.md)
