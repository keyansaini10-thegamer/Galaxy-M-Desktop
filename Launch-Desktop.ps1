<#
.SYNOPSIS
    Forces a standalone secondary landscape desktop workspace on budget Samsung One UI Core devices.
.DESCRIPTION
    Automates local ADB environment checks, verifies connection stability, and spins up a dedicated virtual canvas wrapper.
.REPOSITORY
    GitHub - keyansaini10-thegamer/Galaxy-M-Desktop
#>

Clear-Host
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "  GALAXY M-SERIES OPEN-DEX LAUNCHER v1.1 " -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "Initializing connection link..." -ForegroundColor Yellow

# 1. Audit check to ensure the script is running inside the extracted scrcpy ecosystem folder
if (-not (Test-Path ".\scrcpy.exe") -or -not (Test-Path ".\adb.exe")) {
    Write-Host "[❌ ERROR] Missing core files! You must place this script inside your extracted scrcpy folder." -ForegroundColor Red
    Write-Host "Make sure it sits directly next to 'scrcpy.exe' and 'adb.exe'." -ForegroundColor Yellow
    Exit
}

# 2. Safely scan for connected devices without dropping the driver framework
Write-Host "Scanning for active USB device links..." -ForegroundColor DarkGray
$Devices = .\adb.exe devices

# 3. Enhanced connection verification with built-in device checking loops
$DeviceLine = $Devices | Where-Object { $_ -match '\bdevice\b' }

if (-not $DeviceLine) {
    Write-Host "[⏳ WAITING] Device not fully linked yet. Checking authorization..." -ForegroundColor Yellow
    Write-Host "--> Please unlock your phone screen and tap 'Allow USB Debugging' if prompted." -ForegroundColor White
    
    # Give the phone up to 10 seconds to respond to the USB data handshake
    for ($i = 1; $i -le 5; $i++) {
        Start-Sleep -Seconds 2
        $Devices = .\adb.exe devices
        $DeviceLine = $Devices | Where-Object { $_ -match '\bdevice\b' }
        if ($DeviceLine) { break }
    }
}

if (-not $DeviceLine) {
    Write-Host "[❌ ERROR] No authorized Android device could be found." -ForegroundColor Red
    Write-Host "Troubleshooting Checklist:" -ForegroundColor Yellow
    Write-Host " 1. Unplug your OnePlus cable, wait 3 seconds, and plug it back in."
    Write-Host " 2. Swipe down notifications, verify USB mode is set to 'File Transfer'."
    Write-Host " 3. Verify 'USB Debugging' is still enabled in Developer Options."
    Exit
}

# Extract and clean up the device ID string for UI feedback
$CleanID = $DeviceLine.Split("`t")[0].Trim()
Write-Host "[✓] Device connection verified: $CleanID" -ForegroundColor Green

# 4. Fire up the isolated custom desktop display canvas using the Play Store drawer layout
Write-Host "Injecting isolated virtual landscape viewport (1920x1080)..." -ForegroundColor Yellow
Write-Host "Shortcut Map: Hold [Ctrl + Alt + F] inside the window to toggle Full-Screen Mode." -ForegroundColor LightCyan

# Uses a custom display layout optimized for secondary monitor interfaces
.\scrcpy.exe --new-display=1920x1080 --window-title="OpenDeX Desktop Workspace" --shortcut-mod=lctrl,lalt --start-app=com.android.vending

Write-Host "`n=========================================" -ForegroundColor Cyan
Write-Host "Session closed down cleanly. Goodbye!" -ForegroundColor Gray
Write-Host "=========================================" -ForegroundColor Cyan
