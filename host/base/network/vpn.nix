{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    clash-meta # Clash Meta 内核，支持更多协议和规则
    clash-verge-rev # Clash 图形界面客户端
    v2ray # V2Ray 客户端
    sing-box # 新一代代理工具
    proxychains-ng # 命令行代理工具
    geoip # IP 地理位置数据库
  ];

  systemd.services.clash-meta = {
    enable = true;
    description = "Clash Meta Proxy Service";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.clash-meta}/bin/clash-meta -d /var/lib/clash-meta -f /etc/clash-meta/config.yaml";
      ExecReload = "${pkgs.coreutils}/bin/kill -HUP $MAINPID";
      Restart = "on-failure";
      RestartSec = 5;
      User = "clash-meta";
      Group = "clash-meta";
      DynamicUser = true;
      StateDirectory = "clash-meta";
      ConfigurationDirectory = "clash-meta";
      # 安全配置
      NoNewPrivileges = true;
      ProtectSystem = "strict";
      ProtectHome = true;
      ProtectKernelTunables = true;
      ProtectKernelModules = true;
      ProtectControlGroups = true;
      RestrictAddressFamilies = [
        "AF_UNIX"
        "AF_INET"
        "AF_INET6"
        "AF_NETLINK"
      ];
      RestrictNamespaces = true;
      LockPersonality = true;
      MemoryDenyWriteExecute = true;
      RestrictRealtime = true;
      RestrictSUIDSGID = true;
      PrivateMounts = true;
      # 网络权限
      AmbientCapabilities = [ "CAP_NET_BIND_SERVICE" ];
      CapabilityBoundingSet = [ "CAP_NET_BIND_SERVICE" ];
    };
  };

  # 创建 Clash 配置目录和基础配置
  environment.etc."clash-meta/config.yaml" = {
    text = ''
      # Clash Meta 基础配置
      mixed-port: 7890         # HTTP(S) 和 SOCKS 代理端口
      redir-port: 7892         # 透明代理端口
      tproxy-port: 7893        # TProxy 端口
      allow-lan: true          # 允许局域网连接
      bind-address: '*'        # 绑定地址
      mode: rule               # 代理模式：rule/global/direct
      log-level: info          # 日志级别
      external-controller: 127.0.0.1:9090  # 外部控制器
      external-ui: ui          # Web UI 路径
      secret: ""               # API 密钥

      # 代理配置（需要根据实际情况修改）
      proxies:
        # 示例 Shadowsocks 代理配置 # todo: set to secrets
        - name: "justmysocks1"
          type: ss
          server: "c76s1.portablesubmarines.com"
          port: 13392
          cipher: "aes-256-gcm"
          password: "v7thMbKWvqyVJmzZ"

      # 代理组配置
      proxy-groups:
        - name: "PROXY"
          type: select
          proxies:
            - "justmysocks1"
            - "DIRECT"
        
        - name: "国际流量"
          type: select
          proxies:
            - "PROXY"
            - "DIRECT"
        
        - name: "国内流量"
          type: select
          proxies:
            - "DIRECT"
            - "PROXY"

      # 路由规则
      rules:
        # 国内域名直连
        - DOMAIN-SUFFIX,cn,国内流量
        - DOMAIN-KEYWORD,baidu,国内流量
        - DOMAIN-KEYWORD,taobao,国内流量
        - DOMAIN-KEYWORD,qq,国内流量
        - DOMAIN-KEYWORD,weixin,国内流量
        - DOMAIN-KEYWORD,alipay,国内流量
        - DOMAIN-KEYWORD,163,国内流量
        - DOMAIN-KEYWORD,sina,国内流量
        
        # 国际流量走代理
        - DOMAIN-SUFFIX,google.com,国际流量
        - DOMAIN-SUFFIX,youtube.com,国际流量
        - DOMAIN-SUFFIX,facebook.com,国际流量
        - DOMAIN-SUFFIX,twitter.com,国际流量
        - DOMAIN-SUFFIX,github.com,国际流量
        - DOMAIN-SUFFIX,stackoverflow.com,国际流量
        - DOMAIN-KEYWORD,google,国际流量
        - DOMAIN-KEYWORD,youtube,国际流量
        - DOMAIN-KEYWORD,facebook,国际流量
        - DOMAIN-KEYWORD,twitter,国际流量
        
        # IP 规则
        - IP-CIDR,10.0.0.0/8,DIRECT
        - IP-CIDR,172.16.0.0/12,DIRECT
        - IP-CIDR,192.168.0.0/16,DIRECT
        - IP-CIDR,127.0.0.0/8,DIRECT
        # 注释掉 GEOIP 规则，因为可能无法下载 MMDB 数据库
        # - GEOIP,CN,国内流量
        
        # 默认规则
        - MATCH,国际流量
    '';
    mode = "0644";
  };

  # 系统代理环境变量配置
  environment.variables = {
    HTTP_PROXY = "http://127.0.0.1:7890";
    HTTPS_PROXY = "http://127.0.0.1:7890";
    ALL_PROXY = "socks5://127.0.0.1:7890";
    NO_PROXY = "localhost,127.0.0.1,10.*,192.168.*,172.16.*,172.17.*,172.18.*,172.19.*,172.20.*,172.21.*,172.22.*,172.23.*,172.24.*,172.25.*,172.26.*,172.27.*,172.28.*,172.29.*,172.30.*,172.31.*,*.local,*.cn";
  };

  # ProxyChains 配置
  environment.etc."proxychains.conf" = {
    text = ''
      # ProxyChains 配置
      strict_chain
      proxy_dns
      remote_dns_subnet 224
      tcp_read_time_out 15000
      tcp_connect_time_out 8000
      localnet 127.0.0.0/255.0.0.0
      localnet 10.0.0.0/255.0.0.0
      localnet 172.16.0.0/255.240.0.0
      localnet 192.168.0.0/255.255.0.0

      [ProxyList]
      socks5 127.0.0.1 7890
    '';
    mode = "0644";
  };

  # 网络配置优化
  networking = {
    # 启用 IP 转发
    nat = {
      enable = true;
      internalInterfaces = [ "ve-+" ];
      externalInterface = "eth0"; # 根据实际网卡名称调整
    };

    # 防火墙配置
    firewall = {
      allowedTCPPorts = [
        7890
        7891
        7892
        9090
      ]; # Clash 端口
      allowedUDPPorts = [
        7890
        7891
        7892
      ];
      # 允许内网访问代理
      trustedInterfaces = [ "lo" ];
    };
  };

  # 启用必要的内核模块
  boot.kernelModules = [
    "tun"
    "tap"
  ];

  # 系统服务配置
  systemd.services = {
    # 代理规则更新服务
    update-proxy-rules = {
      description = "Update proxy rules and GeoIP database";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.writeShellScript "update-proxy-rules" ''
          # 更新 GeoIP 数据库
          mkdir -p /var/lib/clash-meta
          cd /var/lib/clash-meta

          # 下载最新的 GeoIP 和 GeoSite 数据库
          ${pkgs.curl}/bin/curl -L -o Country.mmdb https://github.com/Dreamacro/maxmind-geoip/releases/latest/download/Country.mmdb
          ${pkgs.curl}/bin/curl -L -o geosite.dat https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat

          echo "Proxy rules updated successfully"
        ''}";
      };
    };
  };

  # 定时更新代理规则
  systemd.timers.update-proxy-rules = {
    description = "Update proxy rules weekly";
    timerConfig = {
      OnCalendar = "weekly";
      Persistent = true;
    };
    wantedBy = [ "timers.target" ];
  };

  # 用户级别的代理配置
  environment.shellAliases = {
    # 代理相关别名
    proxy-on = "export http_proxy=http://127.0.0.1:7890 https_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890";
    proxy-off = "unset http_proxy https_proxy all_proxy";
    proxy-test = "curl -I --connect-timeout 5 https://www.google.com";
    pc = "proxychains4";
  };

}
