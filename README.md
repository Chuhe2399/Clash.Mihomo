Clash.Mihomo 模块，支持KernelSU、APatch、Magisk

利用TProxy/Tun支持Clash.Mihomo的透明代理

维护作者：kalasutra/MC2K/Chuhe

内核文件目录：/data/adb/modules/Clash.Mihomo/system/bin/

文件配置目录：/data/clash/

内核日志目录：/data/clash/run/

启动关闭内核：模块管理器控制开关

内核下载链接：https://github.com/MetaCubeX/mihomo/releases/tag/Prerelease-Alpha

文件配置示例：https://github.com/MetaCubeX/mihomo/blob/Alpha/docs/config.yaml

附加控制软件：https://t.me/MagiskChangeKing

KsuWebUI：https://github.com/5ec1cff/KsuWebUIStandalone

注：第一次刷入模块重启后需要手动重启内核才能正常使用，修改配置文件需要重启内核才生效，基本很少维护了如果是升级的话自行替换内核就可以了，内核不再指定本地面板需要在线面板进行控制，模块管理器有内置本地面板只支持KernelSU、APatch，但是Magisk需要下载KsuWebUI应用，有需求指定本地面板的可以自行修改配置文件添加指定路径external-ui: “路径”。
