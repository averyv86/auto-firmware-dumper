# Device-Specific Examples

This document provides examples for dumping ROMs and generating device trees for specific devices.

## Samsung Galaxy Tab A9 WiFi (SM-X110 / GTA9WiFi)

### Device Information
- **Model**: SM-X110
- **Codename**: gta9wifi (lowercase)
- **Brand**: Samsung
- **Type**: Tablet
- **Purpose**: Building TWRP custom recovery

### Workflow Configuration

When running the "Auto Firmware Dumper" workflow for this device:

| Field | Value | Notes |
|-------|-------|-------|
| Name in GitHub Account | `your-username` | Your GitHub username |
| E-mail in GitHub Account | `your-email@example.com` | Your GitHub email |
| Stock ROM Link | `https://...` | Link to SM-X110 firmware |
| Create Vendor Tree | `false` | Not needed for TWRP only |
| Upload LineageOS tree | `false` | Not needed for TWRP only |
| Upload TWRP tree | `true` | ✓ Enable for TWRP recovery |

### Finding Stock ROM

Sources for SM-X110 firmware:
1. **SamMobile** (sammobile.com)
2. **SamFw** (samfw.com)
3. **Samfrew** (samfrew.com)
4. **Samsung Updates** (samsung-updates.com)
5. **Frija Tool** (desktop download tool for direct Samsung firmware)

### Expected Output

After successful workflow execution:

1. **ROM Dump Repository**: `dump_samsung_gta9wifi`
   - Contains: system, vendor, boot images, device properties
   - All extracted firmware components

2. **TWRP Device Tree Repository**: `twrp_device_samsung_gta9wifi`
   - Contains: BoardConfig.mk, device.mk, recovery.fstab
   - Ready to use for TWRP compilation

3. **Artifacts**:
   - boot.img (if over 50MB, will be gzipped)
   - recovery.img (if available and over 50MB, will be gzipped)
   - Other partition images

### Building TWRP Recovery

After the workflow completes:

1. Clone the generated TWRP device tree:
   ```bash
   git clone https://github.com/YOUR_USERNAME/twrp_device_samsung_gta9wifi
   ```

2. Set up TWRP build environment (refer to TWRP documentation)

3. Sync TWRP sources:
   ```bash
   repo init -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-12.1
   repo sync
   ```

4. Place device tree in the correct location:
   ```bash
   mv twrp_device_samsung_gta9wifi device/samsung/gta9wifi
   ```

5. Build TWRP:
   ```bash
   . build/envsetup.sh
   lunch twrp_gta9wifi-eng
   mka recoveryimage
   ```

### Troubleshooting

**Issue**: Device codename is uppercase in ROM
- **Solution**: The tool automatically converts to lowercase (GTA9WiFi → gta9wifi)

**Issue**: Missing boot.img or recovery.img
- **Solution**: Check artifacts section in GitHub Actions. Large images may be in artifacts instead of the repository.

**Issue**: TWRP device tree not generated
- **Solution**: Ensure DumprX recognizes the ROM structure. Some ROMs may need manual tree creation after dump.

## Additional Devices

### Adding Your Device

To use this tool for any Android device:

1. **Identify device information**:
   - Brand name (e.g., samsung, xiaomi, oneplus)
   - Device codename (e.g., gta9wifi, raphael, hotdog)
   - Ensure codename is lowercase

2. **Obtain stock firmware**:
   - Official manufacturer sources
   - Firmware repositories
   - Upload to supported hosting (Drive, Mega, etc.)

3. **Run workflow**:
   - Enable TWRP tree for recovery building
   - Enable LineageOS tree for custom ROM development
   - Enable Vendor tree for proprietary blobs

4. **Use generated trees**:
   - Clone repositories created by the workflow
   - Integrate into your build environment
   - Follow respective project documentation (TWRP, LineageOS, etc.)

## Common Workflow Patterns

### Pattern 1: TWRP Recovery Only
- Create Vendor Tree: `false`
- Upload LineageOS tree: `false`
- Upload TWRP tree: `true` ✓

### Pattern 2: LineageOS ROM Development
- Create Vendor Tree: `true` ✓
- Upload LineageOS tree: `true` ✓
- Upload TWRP tree: `false`

### Pattern 3: Complete Development Setup
- Create Vendor Tree: `true` ✓
- Upload LineageOS tree: `true` ✓
- Upload TWRP tree: `true` ✓

## Notes

- The tool uses automated detection for device properties (codename, brand, fingerprint)
- If device properties are not detected correctly, check the ROM's build.prop files
- Large files (>50MB) are automatically compressed or excluded to fit GitHub's limits
- Device trees are generated using `twrpdtgen` and `aospdtgen` tools
- Continue-on-error is enabled for tree uploads, so partial success is possible
