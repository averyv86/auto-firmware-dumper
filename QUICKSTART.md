# Quick Start Guide

This guide will help you quickly dump a ROM and generate device trees for your Android device.

## Prerequisites Checklist

- [ ] GitHub account with a valid email
- [ ] Stock ROM file for your device (downloaded or accessible via link)
- [ ] ROM uploaded to a supported service (Google Drive, Mega, MediaFire, etc.)
- [ ] GitHub Personal Access Token (Classic) with all scopes enabled
- [ ] Forked this repository to your GitHub account
- [ ] Added `GTOKEN` secret to your forked repository

## Step-by-Step Workflow

### 1. Setup GitHub Token

1. Go to GitHub Settings → Developer settings → Personal access tokens → Tokens (classic)
2. Click "Generate new token (classic)"
3. Give it a name (e.g., "Auto Firmware Dumper")
4. Select ALL scopes (check all boxes)
5. Click "Generate token"
6. **IMPORTANT**: Copy the token immediately - you won't see it again!

### 2. Configure Your Forked Repository

1. Fork this repository to your account
2. Go to your forked repository's Settings
3. Navigate to Secrets and variables → Actions
4. Click "New repository secret"
5. Name: `GTOKEN`
6. Value: Paste your token from step 1
7. Click "Add secret"

### 3. Run the Workflow

1. Go to your forked repository
2. Click on "Actions" tab
3. Select "Auto Firmware Dumper" workflow
4. Click "Run workflow" button
5. Fill in the form:

#### Form Fields

| Field | Description | Example |
|-------|-------------|---------|
| **Name in GitHub Account** | Your GitHub username | `octocat` |
| **E-mail in GitHub Account** | Your GitHub email | `octocat@github.com` |
| **Stock ROM Link** | Direct download link to your ROM | `https://drive.google.com/...` |
| **Create Vendor Tree** | Generate vendor blobs tree | ✓ Check if building custom ROM |
| **Upload LineageOS tree** | Generate LineageOS device tree | ✓ Check if building LineageOS |
| **Upload TWRP tree** | Generate TWRP device tree | ✓ Check if building TWRP recovery |

### 4. Wait for Completion

- The workflow typically takes 30-60 minutes depending on ROM size
- Monitor progress in the Actions tab
- Check for any errors in the workflow logs

### 5. Access Your Results

After successful completion, you'll have new repositories in your account:

- `dump_<brand>_<device>` - Complete ROM dump
- `twrp_device_<brand>_<device>` - TWRP device tree (if enabled)
- `lineage_device_<brand>_<device>` - LineageOS device tree (if enabled)
- `android_vendor_<brand>_<device>` - Vendor tree (if enabled)

Check the workflow artifacts for large image files (boot.img, recovery.img, etc.)

## Common Use Cases

### Use Case 1: TWRP Recovery Only (Recommended for SM-X110)

Perfect for building custom recovery:

```
Create Vendor Tree: ☐ false
Upload LineageOS tree: ☐ false
Upload TWRP tree: ☑ true
```

**Result**: ROM dump + TWRP device tree

### Use Case 2: Custom ROM Development

For building custom ROMs like LineageOS:

```
Create Vendor Tree: ☑ true
Upload LineageOS tree: ☑ true
Upload TWRP tree: ☐ false (optional)
```

**Result**: ROM dump + LineageOS tree + Vendor tree

### Use Case 3: Complete Development Environment

Everything you need for full custom development:

```
Create Vendor Tree: ☑ true
Upload LineageOS tree: ☑ true
Upload TWRP tree: ☑ true
```

**Result**: ROM dump + All device trees

## Troubleshooting

### Issue: Workflow fails immediately

**Possible causes:**
- GitHub token not configured correctly
- Token doesn't have all required permissions
- Fork is not up to date

**Solution:**
1. Verify GTOKEN secret is set correctly
2. Regenerate token with ALL scopes
3. Sync your fork with upstream

### Issue: Cannot download ROM

**Possible causes:**
- Link is not a direct download link
- Link requires authentication
- Link is expired or invalid

**Solution:**
1. Use direct download links (not preview/share links)
2. For Google Drive, ensure link is publicly accessible
3. Use services like MediaFire or Mega for easier access

### Issue: Device tree not generated

**Possible causes:**
- ROM structure not recognized by DumprX
- Missing critical partitions
- Device properties not detected

**Solution:**
1. Check workflow logs for specific errors
2. Verify ROM is complete and not corrupted
3. ROM dump will still be created - device tree can be created manually later

### Issue: Files larger than 50MB missing

**Expected behavior:**
- Large files are automatically compressed (gzipped)
- Check workflow artifacts for these files
- Files might be split across dump repo and artifacts

**Solution:**
- Download artifacts from the Actions run
- Decompress gzipped files: `gunzip filename.img.gz`

## Tips for Success

1. **Use Direct Links**: Convert Google Drive share links to direct download format
2. **Check ROM Size**: Very large ROMs (>5GB) take longer to process
3. **Monitor Logs**: Watch the workflow logs for progress and any warnings
4. **Be Patient**: The process can take 30-90 minutes depending on ROM size
5. **Verify Results**: Check that repositories were created successfully
6. **Device Codename**: Tool automatically converts to lowercase (e.g., GTA9WiFi → gta9wifi)

## Next Steps After Dumping

### For TWRP Recovery Building:

1. Clone the generated TWRP device tree
2. Set up TWRP minimal manifest build environment
3. Sync TWRP sources
4. Place device tree in `device/<brand>/<codename>`
5. Build with `lunch twrp_<codename>-eng && mka recoveryimage`

### For LineageOS Building:

1. Clone the LineageOS device tree
2. Clone the vendor tree (if generated)
3. Set up LineageOS build environment
4. Sync LineageOS sources
5. Place trees in appropriate directories
6. Build with `lunch lineage_<codename>-userdebug && mka bacon`

## Additional Resources

- [DumprX Documentation](https://github.com/DumprX/DumprX)
- [TWRP Device Tree Generator](https://github.com/twrpdtgen/twrpdtgen)
- [LineageOS Build Guide](https://wiki.lineageos.org/devices/)
- [Android Platform Development](https://source.android.com/)

## Need Help?

If you encounter issues:

1. Check the workflow logs in GitHub Actions
2. Review this guide and DEVICE_EXAMPLES.md
3. Verify all prerequisites are met
4. Open an issue in the repository with:
   - Your device model and codename
   - ROM source
   - Error messages from workflow logs
   - Steps you've already tried

---

**Remember**: This tool automates the tedious work of extracting and organizing ROM dumps. It's designed to save you hours of manual work, but some manual adjustments might still be needed for specific devices.
