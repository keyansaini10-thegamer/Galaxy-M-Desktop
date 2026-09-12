<#
.SYNOPSIS
    OpenDeX Workspace Launcher Framework v17.0 for Samsung One UI Core.
.DESCRIPTION
    Automates ADB pipelines, pulls down required tools automatically, provisions displays,
    and includes an automated GitHub self-updater engine with a desktop shortcut generator.
.REPOSITORY
    GitHub - keyansaini10-thegamer/Galaxy-M-Desktop
#>

# Current local script version tag
$CurrentVersion = "17.0"

Clear-Host
# =========================================================================
# 🎨 COLORFUL CUSTOM ASCII ART BANNER BY KEYAN SAINI
# =========================================================================
Write-Host "████████╗██╗  ██╗███████╗    ██████╗ ███████╗██╗  ██╗" -ForegroundColor Cyan
Write-Host "╚══██╔══╝██║  ██║██╔════╝    ██╔══██╗██╔════╝╚██╗██╔╝" -ForegroundColor Cyan
Write-Host "   ██║   ███████║█████╗      ██║  ██║█████╗   ╚███╔╝ " -ForegroundColor Cyan
Write-Host "   ██║   ██╔══██║██╔══╝      ██║  ██║██╔══╝   ██╔██╗ " -ForegroundColor Cyan
Write-Host "   ██║   ██║  ██║███████╗    ██████╔╝███████╗██╔╝ ██╗" -ForegroundColor Cyan
Write-Host "   ╚═╝   ╚═╝  ╚═╝╚══════╝    ╚═════╝ ╚══════╝╚═╝  ╚═╝" -ForegroundColor Cyan
Write-Host "=====================================================" -ForegroundColor DarkGray
Write-Host "        💥 GALAXY M/F-SERIES OPEN-DEX v$CurrentVersion 💥" -ForegroundColor Yellow
Write-Host "               ⚙️ Created By Keyan Saini ⚙️" -ForegroundColor Green
Write-Host "=====================================================" -ForegroundColor DarkGray

# =========================================================================
# 🔄 AUTOMATED GITHUB SELF-UPDATER ENGINE
# =========================================================================
Write-Host "`n🔍 Checking GitHub for project updates..." -ForegroundColor Yellow
$RemoteUrl = "https://githubusercontent.com"

try {
    # Fetch the online script snippet to check version tag
    $RemoteScriptSnippet = Invoke-WebRequest -Uri $RemoteUrl -UseBasicParsing -TimeoutSec 5 -ErrorAction Stop | Select-String -Pattern '\$CurrentVersion = "(.*)"'
    if ($RemoteScriptSnippet) {
        $RemoteVersion = $RemoteScriptSnippet.Matches.Groups.Value
        
        # Compare versions
        if ([version]$RemoteVersion -gt [version]$CurrentVersion) {
            Write-Host "✨ A brand new update (v$RemoteVersion) is available on GitHub!" -ForegroundColor Green
            $UpdateChoice = Read-Host "Would you like to automatically update your script now? (Y/N)"
            
            if ($UpdateChoice.ToUpper() -eq "Y") {
                Write-Host "🌍 Downloading latest script from GitHub..." -ForegroundColor Cyan
                $ScriptPath = $MyInvocation.MyCommand.Path
                Invoke-WebRequest -Uri $RemoteUrl -OutFile $ScriptPath -UseBasicParsing -ErrorAction Stop
                Write-Host "[✓] Script updated successfully! Please re-run the script to enjoy new features." -ForegroundColor Green
                Exit
            }
        } else {
            Write-Host "[✓] Your script is fully up to date!" -ForegroundColor Green
        }
    }
} catch {
    Write-Host "[⚠️ WARNING] Could not reach GitHub to check for updates. Running local version." -ForegroundColor DarkGray
}

# 1. Workspace Validation Check
Write-Host "`nInitializing open-source connection link..." -ForegroundColor Yellow
if (-not (Test-Path ".\scrcpy.exe") -or -not (Test-Path ".\adb.exe")) {
    Write-Host "[❌ ERROR] Core files missing! Place this script inside your scrcpy folder next to scrcpy.exe." -ForegroundColor Red
    Exit
}

# 2. Hardware Auditing Check
Write-Host "Scanning for active USB device links..." -ForegroundColor DarkGray
$Devices = .\adb.exe devices
$DeviceLine = $Devices | Where-Object { $_ -match '\bdevice\b' }

if (-not $DeviceLine) {
    Write-Host "[❌ ERROR] Device link failed. Ensure USB Debugging is ON in Developer Options." -ForegroundColor Red
    Exit
}

$CleanID = ($DeviceLine -split '\s+').Trim()
Write-Host "[✓] Device verified: $CleanID" -ForegroundColor Green

# 3. SMART SETUP CHECKER, AUTO-DOWNLOAD, & SHORTCUT CREATOR ENGINE
Write-Host "`nAuditing mobile phone system environment parameters..." -ForegroundColor Yellow
$CheckApp = .\adb.exe shell pm list packages com.farmerbb.taskbar
$CheckPerm = .\adb.exe shell dumpsys package com.farmerbb.taskbar | Select-String -Pattern "android.permission.WRITE_SECURE_SETTINGS: granted=true"
$CheckFreeform = .\adb.exe shell settings get global enable_freeform_support

# --- AUTOMATED DESKTOP SHORTCUT MAKER ---
$DesktopFolder = [Environment]::GetFolderPath("Desktop")
$ShortcutPath = Join-Path $DesktopFolder "Launch OpenDeX Workspace.lnk"

if (-not (Test-Path $ShortcutPath)) {
    Write-Host "🖥️ Creating a quick launch icon on your Windows Desktop..." -ForegroundColor Cyan
    try {
        $WScriptShell = New-Object -ComObject WScript.Shell
        $Shortcut = $WScriptShell.CreateShortcut($ShortcutPath)
        $Shortcut.TargetPath = "powershell.exe"
        # Binds execution policy parameters to let the script run with one click
        $Shortcut.Arguments = "-NoProfile -ExecutionPolicy Bypass -File `"$($MyInvocation.MyCommand.Path)`""
        $Shortcut.WorkingDirectory = $PSScriptRoot
        # Pulls a native system display icon layout to make it look sharp
        $Shortcut.IconLocation = "shell32.dll, 15" 
        $Shortcut.Save()
        Write-Host "[✓] Desktop icon successfully created! You can now launch OpenDeX right from your home screen." -ForegroundColor Green
    } catch {
        Write-Host "[⚠️ WARNING] Could not create a desktop shortcut automatically." -ForegroundColor DarkGray
    }
}
# --------------------------------------------

if (-not $CheckApp -or -not $CheckPerm -or $CheckFreeform -ne "1") {
    Write-Host "[⚠️ WARNING] Your phone is missing the required layout settings to run DeX." -ForegroundColor Yellow
    $UserChoice = Read-Host "Would you like this script to automatically download and configure your phone now? (Y/N)"
    
    if ($UserChoice.ToUpper() -eq "Y") {
        Write-Host "`nRunning automated environmental setup deployment..." -ForegroundColor Cyan
        
        if (-not $CheckApp) {
            if (-not (Test-Path ".\Taskbar.apk")) {
                Write-Host "🌍 Taskbar package not found locally. Fetching latest verified release from internet..." -ForegroundColor Yellow
                $DownloadUrl = "https://github.com"
                try {
                    Invoke-WebRequest -Uri $DownloadUrl -OutFile ".\Taskbar.apk" -ErrorAction Stop
                    Write-Host "[✓] Download complete!" -ForegroundColor Green
                } catch {
                    Write-Host "[❌ ERROR] Internet download failed! Please verify your PC is online and try again." -ForegroundColor Red
                    Exit
                }
            }
            
            Write-Host "-> Installing Taskbar core application package onto phone..." -ForegroundColor DarkGray
            .\adb.exe install -r -g ".\Taskbar.apk" | Out-Null
            Start-Sleep -Seconds 3
        }
        
        # Double check if installation succeeded before trying to grant secure permissions
        $CheckAppAgain = .\adb.exe shell pm list packages com.farmerbb.taskbar
        if ($CheckAppAgain) {
            .\adb.exe shell pm grant com.farmerbb.taskbar android.permission.WRITE_SECURE_SETTINGS | Out-Null
            .\adb.exe shell settings put global enable_freeform_support 1 | Out-Null
            .\adb.exe shell settings put global force_resizable_activities 1 | Out-Null
            Write-Host "[✓] Setup complete! Your phone is now fully configured." -ForegroundColor Green
            Start-Sleep -Seconds 2
        } else {
            Write-Host "[❌ ERROR] Installation failed. Please ensure your device screen is unlocked and try again." -ForegroundColor Red
            Exit
        }
    } else {
        Write-Host "[❌ CANCELLED] Cannot run OpenDeX desktop without required settings. Exiting." -ForegroundColor Red
        Exit
    }
} else {
    Write-Host "[✓] System audit passed! All desktop parameters are already active." -ForegroundColor Green
}

# 4. START SEQUENCE: Set Taskbar as the default home workspace
Write-Host "Injecting Taskbar framework as the default system home workspace..." -ForegroundColor Yellow
.\adb.exe shell cmd package set-home-activity com.farmerbb.taskbar/.activity.MainActivity | Out-Null
.\adb.exe shell am broadcast -a com.farmerbb.taskbar.START_STOP_TASKBAR --ez start true | Out-Null

# 5. Clean Widescreen Execution: Launches the gorgeous 1080p desktop canvas monitor layer.
Write-Host "Deploying high-definition widescreen desktop shell environment..." -ForegroundColor Yellow
$TargetWindowName = "OpenDeX-Workspace"
$ScrcpyArgs = @(
    "--new-display=1920x1080/160", 
    "--max-fps=60", 
    "--video-bit-rate=16M", 
    "--render-driver=direct3d11", 
    "--window-title=$TargetWindowName", 
    "--shortcut-mod=lctrl,lalt"
)
$Process = Start-Process -FilePath ".\scrcpy.exe" -ArgumentList $ScrcpyArgs -WindowStyle Normal -PassThru

# 6. Interface Polishing: Forces immersive view navigation parameters
Start-Sleep -Seconds 3
.\adb.exe shell settings put global policy_control immersive.navigation=*

Write-Host "OpenDeX Interface active. Monitoring display canvas safely..." -ForegroundColor Green
$Process.WaitForExit()

# 7. Global Environmental Teardown & Reset Pipeline
Write-Host "`n=========================================" -ForegroundColor Cyan
Write-Host "Session closed down cleanly. Cleaning environmental baseline..." -ForegroundColor Yellow

# Stop the Taskbar engine from broadcasting
.\adb.exe shell am broadcast -a com.farmerbb.taskbar.START_STOP_TASKBAR --ez start false | Out-Null
.\adb.exe shell am force-stop com.farmerbb.taskbar | Out-Null

Write-Host "Restoring default launcher to Samsung One UI Home..." -ForegroundColor DarkGray.\adb.exe shell cmd package set-home-activity com.sec.android.app.launcher/.Launcher | Out-Null

Write-Host "Restoring default 3-button navigation key layout..." -ForegroundColor DarkGray.\adb.exe shell settings put global policy_control null.\adb.exe shell wm overscan 0,0,0,0 | Out-Null

Write-Host "[✓] Baseline parameters successfully reset. Phone returned to stock normal state!" -ForegroundColor GreenWrite-Host "=========================================" -ForegroundColor Cyan
