# 小米 / 红米手机去臃肿（HyperOS）

一键卸载系统广告、统计与无用预装，可恢复，不需要 root、不丢数据。

## 卸掉的东西

- MSA 系统广告服务（广告总闸）、系统广告解决方案组件
- 系统数据统计（小米统计）、SystemHelper（后台上传组件）
- 用户反馈、黄页、游戏中心、FM 收音机、多看阅读、系统自带邮件
- 分身空间（user 999）的小米统计（如有）

## 用法

1. 解压 platform-tools（Google 官方 ADB 工具），把 `debloat.bat` / `restore.bat` 和 `platform-tools` 文件夹放在同一目录（或者把两个 bat 复制进 platform-tools 文件夹里，也行）
2. 手机：设置 → 我的设备 → 全部参数 → 连点「HyperOS 版本」7 次 → 开启开发者选项
3. 设置 → 更多设置 → 开发者选项 → 打开「USB 调试」
4. 手机连电脑，手机上点「允许 USB 调试」（可勾选一律允许）
5. 双击 `debloat.bat`，按提示操作
6. 完成后重启手机

## 说明

- 只是把应用从当前用户卸载（`pm uninstall --user 0`），系统文件还在
- 某个显示 `Failure [not installed]`：这版本没预装，正常，跳过即可
- 删错了：运行 `restore.bat` 恢复，或恢复出厂设置
- 系统大版本升级后可能需要重跑一次 `debloat.bat`
- 高通的 `com.qualcomm.qti.services.systemhelper` 是高通自己的服务，不能卸，本脚本不含它
- 应用商店（com.xiaomi.mipicks）本次未删除

## 另外建议

- 设置搜「广告服务」→ 关闭
- 设置搜「用户体验计划」→ 关闭加入
- 文件管理 / 下载管理 / 应用商店 → 设置里关「个性化推荐」
