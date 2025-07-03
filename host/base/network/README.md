# 网络代理配置指南

这个目录包含 NixOS 系统的网络代理配置，提供智能分流和自动代理功能。

## 🚀 功能特性

### 核心功能
- **智能分流**: 自动识别国内外流量，国内直连，国外走代理
- **多协议支持**: 支持 SOCKS5、HTTP、Shadowsocks、V2Ray 等多种代理协议
- **图形化管理**: 提供 Web UI 和桌面客户端进行可视化管理
- **系统级集成**: 自动配置系统代理环境变量
- **命令行工具**: 提供便捷的命令行代理工具

### 包含的工具
- **Clash Meta**: 现代化的代理内核，支持多种协议和高级规则
- **Clash Verge Rev**: 功能强大的图形界面客户端
- **V2Ray**: 经典的代理工具
- **Sing-box**: 新一代高性能代理工具
- **ProxyChains**: 强制指定程序通过代理连接的命令行工具

## 📁 文件结构

```
network/
├── README.md          # 本说明文件
├── default.nix       # 网络模块入口
└── vpn.nix           # 代理配置主文件
```

## ⚙️ 配置说明

### 1. 代理服务配置

代理服务通过 SystemD 管理，配置文件位于 `/etc/clash-meta/config.yaml`：

- **混合端口**: 7890 (HTTP + SOCKS)
- **透明代理端口**: 7892
- **TProxy 端口**: 7893
- **管理界面**: http://127.0.0.1:9090

### 2. 智能路由规则

#### 国内流量直连
- 所有 `.cn` 域名
- 国内主要网站（百度、淘宝、QQ、微信、支付宝等）
- 内网 IP 段（10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16）
- 中国大陆 IP 地址（基于 GeoIP 数据库）

#### 国际流量走代理
- 国外主要网站（Google、YouTube、Facebook、Twitter、GitHub 等）
- 其他所有未匹配的流量

### 3. 代理组配置

- **PROXY**: 主代理组，可选择具体的代理服务器
- **国际流量**: 用于国外网站访问
- **国内流量**: 用于国内网站访问

## 🔧 安装与配置

### 1. 模块引入

在您的 NixOS 配置中引入网络代理模块：

```nix
# 在 configuration.nix 或相应的模块文件中
imports = [
  ./host/base/network
];
```

### 2. 配置代理服务器

编辑 `/etc/clash-meta/config.yaml` 文件，修改代理服务器配置：

```yaml
proxies:
  # SOCKS5 代理示例
  - name: "my-proxy"
    type: socks5
    server: "your-proxy-server.com"
    port: 1080
    username: "your-username"  # 如果需要认证
    password: "your-password"  # 如果需要认证

  # Shadowsocks 代理示例
  - name: "my-ss"
    type: ss
    server: "your-ss-server.com"
    port: 8388
    cipher: "aes-256-gcm"
    password: "your-ss-password"

  # V2Ray 代理示例
  - name: "my-vmess"
    type: vmess
    server: "your-v2ray-server.com"
    port: 443
    uuid: "your-uuid"
    alterId: 0
    cipher: "auto"
    tls: true
```

### 3. 构建和启用

```bash
# 重新构建系统配置
sudo nixos-rebuild switch

# 启动代理服务
sudo systemctl start clash-meta
sudo systemctl enable clash-meta

# 检查服务状态
sudo systemctl status clash-meta
```

## 📖 使用指南

### 1. Shell 命令别名

系统提供了以下便捷的命令别名：

```bash
# 开启终端代理
proxy-on

# 关闭终端代理
proxy-off

# 测试代理连接
proxy-test

# 使用 ProxyChains 运行程序
pc curl https://www.google.com
```

### 2. Web 管理界面

访问 http://127.0.0.1:9090 打开 Clash 的 Web 管理界面：

- 查看连接状态和流量统计
- 切换代理模式（规则/全局/直连）
- 手动选择代理服务器
- 查看和编辑路由规则
- 进行延迟测试和速度测试

### 3. 桌面客户端

使用 `clash-verge-rev` 桌面客户端：

```bash
# 启动桌面客户端
clash-verge-rev
```

提供更直观的图形界面，支持：
- 可视化配置管理
- 系统托盘快速操作
- 自动启动设置
- 流量监控图表

### 4. ProxyChains 使用

强制指定程序通过代理连接：

```bash
# 方式一：使用别名
pc wget https://www.google.com

# 方式二：直接使用
proxychains4 git clone https://github.com/user/repo.git

# 方式三：交互式 shell
proxychains4 bash
```

## 🔍 故障排除

### 1. 检查服务状态

```bash
# 查看 Clash 服务状态
sudo systemctl status clash-meta

# 查看服务日志
sudo journalctl -u clash-meta -f

# 重启服务
sudo systemctl restart clash-meta
```

### 2. 检查端口占用

```bash
# 检查代理端口是否被占用
sudo netstat -tlnp | grep 7890
sudo ss -tlnp | grep 7890
```

### 3. 测试代理连接

```bash
# 测试 HTTP 代理
curl -x http://127.0.0.1:7890 https://www.google.com

# 测试 SOCKS5 代理
curl --socks5 127.0.0.1:7890 https://www.google.com

# 检查代理是否正常工作
proxy-test
```

### 4. 配置文件验证

```bash
# 验证 Clash 配置文件语法
clash-meta -t -f /etc/clash-meta/config.yaml

# 检查配置文件权限
ls -la /etc/clash-meta/config.yaml
```

## 🛡️ 安全配置

### 1. 服务安全

代理服务运行在受限的安全环境中：

- 使用专用的 `clash-meta` 用户运行
- 启用各种安全限制（NoNewPrivileges、ProtectSystem 等）
- 限制网络地址族和命名空间访问
- 禁用内存写入执行和实时调度

### 2. 防火墙配置

自动配置防火墙规则：

- 开放必要的代理端口（7890、7892、9090）
- 信任本地回环接口
- 仅允许必要的网络连接

### 3. 访问控制

- Web 管理界面仅监听本地地址
- 可通过配置文件设置 API 密钥
- 支持基于 IP 的访问控制

## 🔄 自动更新

系统配置了自动更新机制：

### 1. GeoIP 数据库更新

- **频率**: 每周自动更新
- **内容**: Country.mmdb 和 geosite.dat
- **来源**: GitHub 官方仓库

### 2. 手动更新

```bash
# 手动触发更新
sudo systemctl start update-proxy-rules

# 查看更新日志
sudo journalctl -u update-proxy-rules
```

## 📊 监控和日志

### 1. 系统监控

```bash
# 查看代理服务状态
sudo systemctl status clash-meta

# 实时查看日志
sudo journalctl -u clash-meta -f

# 查看错误日志
sudo journalctl -u clash-meta --priority=err
```

### 2. 流量统计

- 通过 Web 界面查看实时流量统计
- 按代理组和规则分类显示流量
- 支持历史流量数据查看

### 3. 连接监控

- 实时显示活跃连接
- 按目标地址和代理方式分类
- 支持连接详情查看和管理

## 🤝 常见问题

### Q1: 代理服务无法启动？

**A**: 检查配置文件语法和代理服务器连接：

```bash
# 验证配置文件
clash-meta -t -f /etc/clash-meta/config.yaml

# 检查网络连接
ping your-proxy-server.com
```

### Q2: 某些网站无法访问？

**A**: 检查路由规则配置，可能需要手动添加规则：

```yaml
rules:
  - DOMAIN-SUFFIX,example.com,国际流量
  - DOMAIN-KEYWORD,keyword,PROXY
```

### Q3: 代理速度慢？

**A**: 尝试以下优化方法：

1. 切换到延迟更低的代理服务器
2. 调整代理模式（规则 → 全局）
3. 检查网络质量和带宽限制

### Q4: 如何添加新的代理服务器？

**A**: 编辑配置文件添加新的代理：

```yaml
proxies:
  - name: "new-proxy"
    type: "ss"  # 或其他类型
    server: "new-server.com"
    port: 8388
    # 其他配置参数...
```

然后重启服务：`sudo systemctl restart clash-meta`

## 📝 更新日志

- **2025-07-04**: 初始版本发布，包含完整的代理配置和智能分流功能
- 未来版本将持续优化性能和添加新功能

## 🔗 相关资源

- [Clash Meta 官方文档](https://wiki.metacubex.one/)
- [V2Ray 官方网站](https://www.v2ray.com/)
- [ProxyChains 使用指南](https://github.com/haad/proxychains)
- [NixOS 网络配置文档](https://nixos.org/manual/nixos/stable/#sec-networking)

---

如有问题或建议，请提交 Issue 或 Pull Request。
