<#
.SYNOPSIS
    Forces a standalone secondary landscape desktop workspace on budget Samsung One UI Core devices.
.DESCRIPTION
    Automates local ADB environment checks, refreshes connection links, and spins up a dedicated virtual canvas wrapper.
#>

Clear-Host
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "  GALAXY M-SERIES OPEN-DEX LAUNCHER v1.0 " -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "Initializing connection link..." -ForegroundColor Yellow

# 1. Audit check to ensure the script is running inside the extracted scrcpy ecosystem folder
if (-not (Test-Path ".\scrcpy.exe") -or -not (Test-Path ".\adb.exe")) {
    Write-Host "[❌ ERROR] Missing core files! You must place this script inside your extracted scrcpy folder." -ForegroundColor Red
    Exit
}

# 2. Cycle the device bridge system to clean out cached USB errors
Write-Host "Refreshing ADB communications pipeline..." -ForegroundColor DarkGray
.\adb.exe kill-server
.\adb.exe start-server | Out-Null

# 3. Check for responsive hardware links
$Devices = .\adb.exe devices
$DeviceCount = ($Devices | Measure-Object -Line).Lines - 4

if ($DeviceCount -lt 1) {
    Write-Host "[❌ ERROR] No responsive Android phone detected." -ForegroundColor Red
    Write-Host "Troubleshooting Checklist:" -ForegroundColor Yellow
    Write-Host " 1. Ensure your premium high-speed USB data cable is physically connected."
    Write-Host " 2. Verify that 'USB Debugging' is active in Developer Options."
    Write-Host " 3. Check your phone screen right now and tap 'Allow USB Debugging'."
    Exit
}

Write-Host "[✓] Device connection verified!" -ForegroundColor Green

# 4. Fire up the isolated custom desktop display canvas using the Play Store drawer layout
Write-Host "Injecting isolated virtual landscape viewport (1920x1080)..." -ForegroundColor Yellow
Write-Host "Shortcut Map: Hold [Ctrl + Alt + F] inside the window to toggle Full-Screen Mode." -ForegroundColor LightCyan

.\scrcpy.exe --new-display=1920x1080 --window-title="OpenDeX Desktop Workspace" --shortcut-mod=lctrl,lalt --start-app=com.android.vending

Write-Host "Session closed down cleanly." -ForegroundColor Gray
