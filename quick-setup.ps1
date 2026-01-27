#!/usr/bin/env pwsh
# Quick Auto Setup - All parameters

param(
    [Parameter(Mandatory=$true)]
    [string]$Token,
    
    [Parameter(Mandatory=$true)]
    [string]$Username,
    
    [Parameter(Mandatory=$true)]
    [string]$Email
)

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  Auto Firmware Dumper - Quick Setup" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# Step 1: Configure Git
Write-Host "[1/5] Configuring Git..." -ForegroundColor Yellow
git config user.name "$Username"
git config user.email "$Email"
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
    Write-Host "Installing GitHub CLI..." -ForegroundColor Yellow
    winget install --id GitHub.cli -e --silent
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    Start-Sleep -Seconds 3
}
Write-Host "✓ GitHub CLI ready`n" -ForegroundColor Green

# Step 4: Authenticate
Write-Host "[4/5] Authenticating with GitHub..." -ForegroundColor Yellow
$Token | gh auth login --with-token 2>&1 | Out-Null
Write-Host "✓ Authenticated`n" -ForegroundColor Green

# Step 5: Create repository
Write-Host "[5/5] Creating GitHub repository..." -ForegroundColor Yellow
$repoName = "auto-firmware-dumper"
gh repo create $repoName --public --description "Auto Firmware Dumper - Extract Android firmware and generate device trees" --source=. --remote=origin --push 2>&1 | Out-Null

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Repository created!`n" -ForegroundColor Green
    
    # Add secret
    Write-Host "Adding GTOKEN secret..." -ForegroundColor Yellow
    $Token | gh secret set GTOKEN --repo="$Username/$repoName" 2>&1 | Out-Null
    Write-Host "✓ Secret configured!`n" -ForegroundColor Green
    
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "  Setup Complete! 🎉" -ForegroundColor Green
    Write-Host "========================================`n" -ForegroundColor Cyan
    
    Write-Host "Repository: https://github.com/$Username/$repoName" -ForegroundColor Cyan
    Write-Host "Actions: https://github.com/$Username/$repoName/actions`n" -ForegroundColor Cyan
    
    Start-Process "https://github.com/$Username/$repoName/actions"
} else {
    Write-Host "✗ Failed to create repository" -ForegroundColor Red
}
