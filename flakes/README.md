# Flakes
有些工具通过flake发布，相比一般的module配置要复杂一些，我还不完全熟悉。

我当前的认知：
- 作为flake有自己独立的flake.lock，可以单独管理
- 方便共享
- 方便将系统配置和用户配置按照功能集中
- 通过导出module接入一般的nix module系统中
- 从当前角度看，我的系统配置flake基于当前目录下的flakes (它们被放置在inputs中)

总体而言，尽可能使用flake似乎是合理的。