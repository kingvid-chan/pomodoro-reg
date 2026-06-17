# Architecture — 番茄钟计时器 (pomodoro-reg)

## 概述

纯前端番茄钟计时器，25 分钟固定倒计时，面向桌面浏览器。单文件自包含 SPA，零依赖。

## 技术栈

- **前端**：HTML5 + CSS3 + Vanilla JavaScript（单文件 `src/index.html`，内嵌所有样式与脚本）
- **部署**：Nginx 静态服务，子路径 `/projects/pomodoro-reg/`
- **运行时**：浏览器，无 Node.js/构建工具/CDN 外部资源

## 组件

### src/index.html
自包含的单页面应用：
- CSS 样式内嵌在 `<style>` 标签（含完成状态动画 `@keyframes pulse`）
- JavaScript 逻辑内嵌在 `<script>` 标签（IIFE 封装，`"use strict"`）
- 无外部资源引用，无需 `<base>` 标签

### 状态机
```
IDLE → (点击"开始") → RUNNING
RUNNING → (点击"暂停") → PAUSED
PAUSED → (点击"继续") → RUNNING
RUNNING → (归零 00:00) → FINISHED
RUNNING → (点击"重置") → IDLE
PAUSED → (点击"重置") → IDLE
FINISHED → (点击"重置") → IDLE
```

状态枚举：`IDLE | RUNNING | PAUSED | FINISHED`

### 视觉反馈
- **默认状态**：深蓝背景 `#1a1a2e`，白色计时器文字
- **FINISHED 状态**：body 添加 `.finished` class
  - 背景从深蓝过渡到深绿 `#1b5e20`（0.5s ease 过渡）
  - 计时器：font-size 8rem → 10rem，font-weight 200 → 700，颜色变为 `#a5d6a7`
  - pulse 动画：opacity 在 1 和 0.6 之间 1.2s 周期振荡
  - 按钮边框和文字变为 `#a5d6a7`

### 按钮状态控制
| 状态 | btn-start | btn-pause | btn-reset |
|------|-----------|-----------|-----------|
| IDLE | 启用（"开始"） | 禁用 | 启用 |
| RUNNING | 禁用（"继续"） | 启用 | 启用 |
| PAUSED | 启用（"继续"） | 禁用 | 启用 |
| FINISHED | 禁用 | 禁用 | 启用 |

## 数据流

- 所有状态存储于 JavaScript 内存变量（`state`、`remaining`、`intervalId`）
- 无持久化（localStorage/cookie/sessionStorage）
- 无网络请求（fetch/XHR）
- 无用户数据收集
- 页面刷新即重置为初始状态

## 部署

参见 [runbook.md](runbook.md)

## 已知技术债

- setInterval 在浏览器 tab 后台时可能降频（非精确计时场景可接受）

## 关联 ADR 与最近变更

- 2026-06-17: 迭代 0.0.1 — 初始实现，单文件番茄钟计时器
