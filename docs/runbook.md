# 番茄钟计时器 运行手册

## 本地启动

```bash
cd src && python3 -m http.server 8600
# 访问 http://localhost:8600/index.html
```

或用任意静态文件服务器：
```bash
npx serve src -p 8600
```

## 测试

纯前端，浏览器直接打开验证：
1. 检查显示 "25:00"
2. 点击"开始"，确认倒计时逐秒递减
3. 点击"暂停"，确认停止
4. 点击"继续"，确认恢复
5. 等待归零（或修改 JS 加速测试），确认绿色高亮
6. 点击"重置"，确认回到 25:00

## 环境变量

无需环境变量。纯静态 HTML。

## Base Path

项目部署在 `/projects/pomodoro-reg/`。HTML 使用 `<base href="/projects/pomodoro-reg/">` 确保所有资源路径正确。

## 缓存策略

- **HTML 文档**：Nginx 配置必须返回 `Cache-Control: no-cache` 响应头
  ```nginx
  location /projects/pomodoro-reg/ {
      add_header Cache-Control "no-cache";
  }
  ```
- **静态资源**：当前版本自包含无外部资源。如有则带 `?v=0.0.N` 版本令牌

## Aliyun systemd 与 Nginx

### 部署路径
```
/srv/codingagent/pomodoro-reg/src/index.html
```

### systemd 服务（如使用 Flask 后端）
当前版本为纯静态，直接在 Nginx 中 serve：
```nginx
location /projects/pomodoro-reg/ {
    alias /srv/codingagent/pomodoro-reg/src/;
    index index.html;
    add_header Cache-Control "no-cache";
}
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
3. **端口冲突**：当前分配 8600，检查 `ss -tlnp | grep 8600`

## 回滚到精确 Tag

```bash
git fetch --tags && git checkout 0.0.1
# 重新部署 src/index.html
```
