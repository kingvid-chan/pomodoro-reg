# 番茄钟计时器 运行手册

## 本地启动

```bash
cd src && python3 -m http.server 18151
# 访问 http://localhost:18151/index.html
```

或用任意静态文件服务器：
```bash
npx serve src -p 18151
```

## 测试

纯前端，浏览器直接打开验证：

1. 检查显示 "25:00"
2. 点击"开始"，确认倒计时逐秒递减
3. 点击"暂停"，确认停止
4. 点击"继续"（原开始按钮），确认恢复
5. 等待归零（或修改 JS 中 `WORK_SECONDS` 为较小值如 5 加速测试），确认：
   - 显示 "00:00"
   - 背景变为绿色
   - 计时器文字变大、加粗、变绿
   - pulse 动画生效
6. 点击"重置"，确认回到 25:00，绿色高亮消失

### 快速归零测试
修改 `src/index.html` 中的 `WORK_SECONDS`：
```javascript
var WORK_SECONDS = 5;   // 改为 5 秒快速验证
```
测试完成后恢复为 `25 * 60`。

## 环境变量

无需环境变量。纯静态 HTML。

## Base Path

项目部署在 `/projects/pomodoro-reg/`。纯内嵌文件无需 `<base>` 标签或资源路径处理。

Nginx 配置示例：
```nginx
location /projects/pomodoro-reg/ {
    alias /srv/codingagent/pomodoro-reg/src/;
    index index.html;
    add_header Cache-Control "no-cache";
}
```

## 缓存策略

- **HTML 文档**：Nginx 配置必须返回 `Cache-Control: no-cache` 响应头（不能用 `<meta>` 标签代替）
- **静态资源**：当前版本无外部静态资源（CSS/JS 内嵌）。如有则带 `?v=0.0.N` 版本令牌，路径保留 `/projects/pomodoro-reg/` 前缀

## Aliyun systemd 与 Nginx

### 部署路径
```
/srv/codingagent/pomodoro-reg/src/index.html
```

### 健康检查
```bash
curl -I http://120.24.117.67/projects/pomodoro-reg/
# 应返回 HTTP 200 + Cache-Control: no-cache
```

## 日志查看

Nginx 访问日志：
```bash
ssh aliyun-cowork "tail -50 /var/log/nginx/access.log | grep pomodoro-reg"
```

## 常见故障与恢复

1. **404 错误**：检查 Nginx location 配置 `root` vs `alias`，确认文件路径
2. **缓存旧页面**：检查响应头是否有 `Cache-Control: no-cache`
3. **端口冲突**：当前分配 18151，检查 `ss -tlnp | grep 18151`

## 回滚到精确 Tag

```bash
git fetch --tags && git checkout 0.0.1
# 重新部署 src/index.html
```
