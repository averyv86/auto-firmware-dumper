# Auto Firmware Dumper
It allows you to create ROM dumps using GitHub actions. It uses [DumprX](https://github.com/DumprX/DumprX) when creating dumps.  
English | [简体中文](./README_CN.md)

## What can this tool do?
- Extract and dump firmware from stock ROM files
- Generate TWRP-compatible device trees for building custom recoveries
- Generate LineageOS-compatible device trees
- Create vendor trees for custom ROM development
- Automatically upload dumps and device trees to separate GitHub repositories
## Requirements
- ROM Link [mediafire | mega.nz | gdrive | AndroidFileHost OR Directly download link]
- GitHub token (I will explain)
- Patience

## Instruction for use
- Go to the GitHub account settings. Create an access token there. Token type should be classic. Mark all the boxes. And copy the token immediately. Because you won't see it again
- Fork this repository.
- Go to Settings of the forked repository.
- Then go to Secrets and Variables, and tap Action in dropdown choices.
- Tap New Repository Secrets;
Add this:
`GTOKEN`
`<paste here your token>`
- Then tap Add Secrets.
- If actions are not enabled, enable them from settings.
- Go to: this repository > Actions > All workflows> Auto Firmware Dumper > Run workflows > Fill in the requested information.
- When the process is completed, you will have the following among your repositories: dump_`<brand>`_`<device>`. And if you've approved it, the repository of device trees you've approved. You will understand when you look.

For device-specific examples and detailed guidance, see [DEVICE_EXAMPLES.md](./DEVICE_EXAMPLES.md)

## Example: Building TWRP Recovery for Samsung SM-X110 (GTA9WiFi)

If you want to dump a ROM to build TWRP recovery for a specific device like the Samsung Galaxy Tab A9 WiFi (SM-X110/GTA9WiFi), follow these steps:

1. **Find the stock ROM**: Locate the official firmware for your SM-X110 device from sources like:
   - SamFw.com
   - Samfrew.com  
   - Samsung Updates
   - Or any trusted firmware repository

2. **Upload to a supported host**: Upload the ROM to one of these services:
   - Google Drive (get shareable link)
   - Mega.nz
   - MediaFire
   - AndroidFileHost
   - Or use a direct download link

3. **Run the workflow** with these inputs:
   - **Name in GitHub Account**: Your GitHub username
   - **E-mail in GitHub Account**: Your GitHub email
   - **Stock ROM Link**: The download link to your SM-X110 firmware
   - **Create Vendor Tree**: `false` (unless you need vendor blobs)
   - **Upload LineageOS tree**: `false` (unless you need LineageOS support)
   - **Upload TWRP tree**: `true` ✓ (Enable this for TWRP recovery!)

4. **Results**: After the workflow completes, you'll get:
   - `dump_samsung_gta9wifi` repository with full ROM dump
   - `twrp_device_samsung_gta9wifi` repository with TWRP device tree
   - Image files (boot.img, recovery.img, etc.) as artifacts

5. **Build TWRP**: Clone the TWRP device tree repository and follow TWRP building instructions to compile your custom recovery.

## Small explanations and notes
- This project is licensed under the `Eclipse Public License 2.0`
- Any deficiencies or problems on the dump are caused by Stock ROM.
- I'm still developing it. But still good.
- **Device codename must be lowercase**: If there is a capital letter in the device code name, the tool will automatically convert it to lowercase (e.g., GTA9WiFi → gta9wifi).
- Report problems.
- Make sure you fill in the information correctly.
- It is imperative to enter all the desired information.
- If you want some trees/resources to be loaded separately, you must check the relevant box.
- 50MB and over files will be deleted. Reason: GitHub's maximum file size is 50MB. Files larger than this will be compressed or removed to prevent upload failures.
