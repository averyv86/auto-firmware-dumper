# 自动固件转储器
它允许您使用 GitHub Actions 创建 ROM 转储。在创建转储时，它使用 [DumprX](https://github.com/DumprX/DumprX)。

## 此工具可以做什么？
- 从官方 ROM 文件中提取和转储固件
- 生成与 TWRP 兼容的设备树以构建自定义恢复
- 生成与 LineageOS 兼容的设备树
- 为自定义 ROM 开发创建供应商树
- 自动将转储和设备树上传到单独的 GitHub 仓库

## 要求
- ROM 链接 [mediafire | mega.nz | gdrive | AndroidFileHost 或直接下载链接]
- GitHub 令牌（我会解释）
- 耐心

## 使用说明
- 前往 GitHub 账户设置。在那里创建一个访问令牌。令牌类型应为经典。勾选所有框。并立即复制令牌。因为您将无法再次看到
- 分叉这个仓库。
- 前往分叉仓库的设置。
- 然后前往 Secrets 和 Variables，从下拉选择中选择 Action。
- 点击 New Repository Secrets；
添加以下内容：
`GTOKEN`
`<在这里粘贴您的令牌名称>`
- 然后点击 Add Secrets。
- 如果动作未启用，请从设置中启用它们。
- 前往：这个仓库 > Actions > 所有工作流 > Auto Firmware Dumper > 运行工作流 > 填写请求的信息。
- 当过程完成后，您将在仓库中拥有以下内容：dump_`<品牌>`_`<设备>`。如果您已批准，您将拥有您已批准的设备树仓库。当您查看时，您会明白。

## 示例：为三星 SM-X110 (GTA9WiFi) 构建 TWRP 恢复

如果您想转储 ROM 以为特定设备构建 TWRP 恢复，例如三星 Galaxy Tab A9 WiFi (SM-X110/GTA9WiFi)，请按照以下步骤操作：

1. **查找官方 ROM**：从以下来源找到您的 SM-X110 设备的官方固件：
   - SamFw.com
   - Samfrew.com  
   - Samsung Updates
   - 或任何可信的固件存储库

2. **上传到支持的主机**：将 ROM 上传到以下服务之一：
   - Google Drive（获取可共享链接）
   - Mega.nz
   - MediaFire
   - AndroidFileHost
   - 或使用直接下载链接

3. **运行工作流**，输入以下信息：
   - **GitHub 账户中的名称**：您的 GitHub 用户名
   - **GitHub 账户中的电子邮件**：您的 GitHub 电子邮件
   - **官方 ROM 链接**：您的 SM-X110 固件的下载链接
   - **创建供应商树**：`false`（除非您需要供应商 blobs）
   - **上传 LineageOS 树**：`false`（除非您需要 LineageOS 支持）
   - **上传 TWRP 树**：`true` ✓（为 TWRP 恢复启用此选项！）

4. **结果**：工作流完成后，您将获得：
   - `dump_samsung_gta9wifi` 仓库，包含完整的 ROM 转储
   - `twrp_device_samsung_gta9wifi` 仓库，包含 TWRP 设备树
   - 图像文件（boot.img、recovery.img 等）作为工件

5. **构建 TWRP**：克隆 TWRP 设备树仓库并按照 TWRP 构建说明编译您的自定义恢复。

## 小解释和注意事项
- 该项目采用 `Eclipse Public License 2.0` 许可证。
- 转储中的任何不足或问题都是由 Stock ROM 引起的。
- 我仍在开发它。但仍然很好。
- **设备代码名称必须是小写**：如果设备代码名称中有大写字母，工具将自动将其转换为小写（例如，GTA9WiFi → gta9wifi）。
- 报告问题。
- 确保您正确填写信息。
- 输入所有所需信息是必要的。
- 如果您希望某些树/资源单独加载，请必须检查相应的框。
- 50MB 及以上的文件将被删除。原因：GitHub 的最大文件大小为 50MB。超过此大小的文件将被压缩或删除以防止上传失败。
