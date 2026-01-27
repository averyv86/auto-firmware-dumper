#!/usr/bin/env pwsh
# Auto Firmware Dumper Setup Script

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  Auto Firmware Dumper Setup" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# Step 1: Get user information
Write-Host "[1/5] Configuring Git..." -ForegroundColor Yellow
$username = Read-Host "Enter your GitHub username"
$email = Read-Host "Enter your GitHub email"

git config user.name "$username"
git config user.email "$email"
Write-Host "✓ Git configured`n" -ForegroundColor Green

# Step 2: Commit files
Write-Host "[2/5] Committing files..." -ForegroundColor Yellow
git add .
git commit -m "Initial commit - Auto Firmware Dumper" 2>&1 | Out-Null
git branch -M main
Write-Host "✓ Files committed`n" -ForegroundColor Green

# Step 3: Check GitHub CLI
Write-Host "[3/5] Checking GitHub CLI..." -ForegroundColor Yellow
$ghInstalled = Get-Command gh -ErrorAction SilentlyContinue
if (-not $ghInstalled) {
    Write-Host "✗ GitHub CLI not found. Installing..." -ForegroundColor Red
    Write-Host "Installing via winget..." -ForegroundColor Yellow
    winget install --id GitHub.cli -e --silent
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    Start-Sleep -Seconds 3
}
Write-Host "✓ GitHub CLI ready`n" -ForegroundColor Green

# Step 4: Authenticate with GitHub
Write-Host "[4/5] Authenticating with GitHub..." -ForegroundColor Yellow
Write-Host "You will need a GitHub Personal Access Token with repo and workflow permissions." -ForegroundColor Cyan
Write-Host "Get one at: https://github.com/settings/tokens/new`n" -ForegroundColor Cyan
$token = Read-Host "Enter your GitHub Personal Access Token" -AsSecureString
$tokenPlain = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($token))
$tokenPlain | gh auth login --with-token 2>&1 | Out-Null
Write-Host "✓ Authenticated`n" -ForegroundColor Green

# Step 5: Create repository and push
Write-Host "[5/5] Creating GitHub repository..." -ForegroundColor Yellow
$repoName = "auto-firmware-dumper"
gh repo create $repoName --public --description "Auto Firmware Dumper - Extract Android firmware and generate device trees" --source=. --remote=origin --push

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Repository created and pushed!`n" -ForegroundColor Green
    
    # Add the token as a secret
    Write-Host "Adding GTOKEN secret to repository..." -ForegroundColor Yellow
    $tokenPlain | gh secret set GTOKEN --repo="$username/$repoName"
    Write-Host "✓ Secret added!`n" -ForegroundColor Green
    
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "  Setup Complete! 🎉" -ForegroundColor Green
    Write-Host "========================================`n" -ForegroundColor Cyan
    
    Write-Host "Repository URL: https://github.com/$username/$repoName" -ForegroundColor Cyan
    Write-Host "`nNext steps:" -ForegroundColor Yellow
    Write-Host "1. Go to: https://github.com/$username/$repoName/actions" -ForegroundColor White
    Write-Host "2. Click Auto Firmware Dumper workflow" -ForegroundColor White
    Write-Host "3. Click Run workflow button" -ForegroundColor White
    Write-Host "4. Enter your details and firmware URL" -ForegroundColor White
    Write-Host "5. Click Run workflow button to start`n" -ForegroundColor White
    
    # Open browser
    $openBrowser = Read-Host "Open Actions page in browser? (Y/n)"
    if ($openBrowser -ne "n") {
        Start-Process "https://github.com/$username/$repoName/actions"
    }
} else {
    Write-Host "✗ Failed to create repository" -ForegroundColor Red
    Write-Host "You may need to create it manually at: https://github.com/new" -ForegroundColor Yellow
}
