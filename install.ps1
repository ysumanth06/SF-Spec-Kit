# SF Spec-Kit Automated Installer (Windows PowerShell)
# Usage: .\install.ps1 -IDE "cursor" | "antigravity" | "all" [-Yes]

param (
    [string]$IDE = "all",
    [switch]$Yes = $false
)

# 0. Admin Check (required for npm -g, winget, and symbolic links/junctions)
$IsAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

Write-Host "🚀 Initializing SFSpeckit..." -ForegroundColor Cyan

# 1. Dependency Check & Auto-Install
$HasSf = $true
$HasGh = $true

function Get-UserChoice {
    param([string]$Message)
    if ($Yes) { return $true }
    $choice = Read-Host "$Message (y/n)"
    return ($choice -match "^[Yy]$")
}

function Check-And-Install-SF {
    if (-not (Get-Command sf -ErrorAction SilentlyContinue)) {
        Write-Host "❌ Salesforce CLI (sf) not found." -ForegroundColor Red
        Write-Host "   Impact: /sfspeckit-implement, /sfspeckit-deploy, and /sfspeckit-verify will not function." -ForegroundColor Gray
        
        if (Get-Command npm -ErrorAction SilentlyContinue) {
            if (Get-UserChoice "❓ Would you like to install Salesforce CLI via npm?") {
                if (-not $IsAdmin) {
                    Write-Host "⚠️  Warning: npm global install may fail without Administrator privileges." -ForegroundColor Yellow
                }
                Write-Host "Installing @salesforce/cli globally..." -ForegroundColor Cyan
                npm install --global @salesforce/cli
                if (Get-Command sf -ErrorAction SilentlyContinue) { $script:HasSf = $true } else { $script:HasSf = $false }
            } else {
                $script:HasSf = $false
            }
        } elseif (Get-Command winget -ErrorAction SilentlyContinue) {
            if (Get-UserChoice "❓ Would you like to install Salesforce CLI via Winget?") {
                winget install Salesforce.CLI
                if (Get-Command sf -ErrorAction SilentlyContinue) { $script:HasSf = $true } else { $script:HasSf = $false }
            } else {
                $script:HasSf = $false
            }
        } else {
            $script:HasSf = $false
        }
    }
}

function Check-And-Install-GH {
    if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
        Write-Host "❌ GitHub CLI (gh) not found." -ForegroundColor Red
        Write-Host "   Impact: /sfspeckit-pr will not function." -ForegroundColor Gray
        
        if (Get-Command winget -ErrorAction SilentlyContinue) {
            if (Get-UserChoice "❓ Would you like to install GitHub CLI via Winget?") {
                winget install GitHub.cli
                if (Get-Command gh -ErrorAction SilentlyContinue) { $script:HasGh = $true } else { $script:HasGh = $false }
            } else {
                $script:HasGh = $false
            }
        } else {
            Write-Host "💡 Please install GitHub CLI manually from https://cli.github.com/" -ForegroundColor Cyan
            $script:HasGh = $false
        }
    }
}

Check-And-Install-SF
Check-And-Install-GH

if (-not $script:HasSf -or -not $script:HasGh) {
    Write-Host ""
    if (Get-UserChoice "⚠️  Some dependencies are missing. Proceed with linking skills anyway?") {
        # Continue
    } else {
        Write-Host "Installation aborted." -ForegroundColor Yellow
        exit 1
    }
}

# 2. Setup SFSpeckit Directory Structure in Project Root
# Use $PSScriptRoot for robust absolute pathing
$SDK_DIR = $PSScriptRoot
$PROJECT_ROOT = (Get-Item $SDK_DIR).Parent.FullName
$SFSPEC_ROOT = Join-Path $PROJECT_ROOT "sfspeckit"

if (-not (Test-Path "$SFSPEC_ROOT\memory")) { New-Item -ItemType Directory -Path "$SFSPEC_ROOT\memory" -Force }
if (-not (Test-Path "$SFSPEC_ROOT\specs")) { New-Item -ItemType Directory -Path "$SFSPEC_ROOT\specs" -Force }

Write-Host "📂 Created directory structure at $SFSPEC_ROOT"

# 3. Create Skill Links
$SOURCE_DIR = Join-Path $SDK_DIR ".agents\skills"

if (-not (Test-Path $SOURCE_DIR)) {
    Write-Host "❌ Error: Could not find skills source directory at $SOURCE_DIR" -ForegroundColor Red
    exit 1
}

function Setup-Antigravity {
    Write-Host "🤖 Setting up Antigravity skills..." -ForegroundColor Cyan
    $DEST_DIR = Join-Path $PROJECT_ROOT ".agents\skills"
    if (-not (Test-Path $DEST_DIR)) { New-Item -ItemType Directory -Path $DEST_DIR -Force }
    
    Get-ChildItem $SOURCE_DIR | ForEach-Object {
        $destPath = Join-Path $DEST_DIR $_.Name
        # Clear existing junction if it exists to avoid errors
        if (Test-Path $destPath) { Remove-Item $destPath -Force -Recurse }
        New-Item -ItemType Junction -Path $destPath -Target $_.FullName -Force | Out-Null
    }
}

function Setup-Cursor {
    Write-Host "🖱️  Setting up Cursor rules..." -ForegroundColor Cyan
    $DEST_DIR = Join-Path $PROJECT_ROOT ".cursor\rules"
    if (-not (Test-Path $DEST_DIR)) { New-Item -ItemType Directory -Path $DEST_DIR -Force }
    
    Get-ChildItem $SOURCE_DIR -Directory | ForEach-Object {
        $skillName = $_.Name
        $skillFile = Join-Path $_.FullName "SKILL.md"
        $destPath = Join-Path $DEST_DIR "$skillName.md"
        
        # Clear existing hard link if it exists
        if (Test-Path $destPath) { Remove-Item $destPath -Force }
        New-Item -ItemType HardLink -Path $destPath -Target $skillFile -Force | Out-Null
    }
}

switch ($IDE) {
    "antigravity" { Setup-Antigravity }
    "cursor" { Setup-Cursor }
    "all" { 
        Setup-Antigravity
        Setup-Cursor
    }
    default { Write-Host "Unknown IDE: $IDE. Skipping skill linking." }
}

Write-Host "✅ Installation complete!" -ForegroundColor Green
Write-Host "👉 Next step: Run '/sfspeckit-constitution' in your AI agent to begin."
