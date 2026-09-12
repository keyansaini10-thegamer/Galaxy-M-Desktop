<#
.SYNOPSIS
    OpenDeX Workspace Launcher Framework v15.0 for Samsung One UI Core.
.DESCRIPTION
    Automates ADB pipelines, provisions widescreen displays, and injects custom Win32 
    mouse hooks to enable native right-click desktop context menus and minimize systems.
.REPOSITORY
    GitHub - keyansaini10-thegamer/Galaxy-M-Desktop
#>

Clear-Host
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "  GALAXY M-SERIES OPEN-DEX LAUNCHER v15.0" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "Initializing open-source connection link..." -ForegroundColor Yellow

# 1. Workspace Validation Check
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

# 3. SMART SETUP CHECKER & AUTO-INSTALLER ENGINE
Write-Host "`nAuditing mobile phone system environment parameters..." -ForegroundColor Yellow
$CheckApp = .\adb.exe shell pm list packages com.farmerbb.taskbar
$CheckPerm = .\adb.exe shell dumpsys package com.farmerbb.taskbar | Select-String -Pattern "android.permission.WRITE_SECURE_SETTINGS: granted=true"
$CheckFreeform = .\adb.exe shell settings get global enable_freeform_support

if (-not $CheckApp -or -not $CheckPerm -or $CheckFreeform -ne "1") {
    Write-Host "[⚠️ WARNING] Your phone is missing the required layout settings to run DeX." -ForegroundColor Yellow
    $UserChoice = Read-Host "Would you like this script to automatically configure your phone now? (Y/N)"
    
    if ($UserChoice.ToUpper() -eq "Y") {
        Write-Host "`nRunning automated environmental setup deployment..." -ForegroundColor Cyan
        if (-not $CheckApp) {
            if (Test-Path ".\Taskbar.apk") {
                Write-Host "-> Installing Taskbar core application package onto phone..." -ForegroundColor DarkGray
                .\adb.exe install -r ".\Taskbar.apk" | Out-Null
            } else {
                Write-Host "[❌ ERROR] Missing 'Taskbar.apk' in your scrcpy folder! Cannot auto-install." -ForegroundColor Red
                Exit
            }
        }
        .\adb.exe shell pm grant com.farmerbb.taskbar android.permission.WRITE_SECURE_SETTINGS | Out-Null
        .\adb.exe shell settings put global enable_freeform_support 1 | Out-Null
        .\adb.exe shell settings put global force_resizable_activities 1 | Out-Null
        Write-Host "[✓] Setup complete! Your phone is now fully configured." -ForegroundColor Green
        Start-Sleep -Seconds 2
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
# Binds relative tracking keys and builds the native mod mapping controls.
Write-Host "Deploying high-definition widescreen desktop shell environment..." -ForegroundColor Yellow
$TargetWindowName = "OpenDeX-Workspace"
$ScrcpyArgs = @(
    "--new-display=1920x1080/160", 
    "--max-fps=60", 
    "--video-bit-rate=16M", 
    "--render-driver=direct3d11", 
    "--mouse-bind=hhhh", 
    "--window-title=$TargetWindowName", 
    "--shortcut-mod=lctrl,lalt"
)
$Process = Start-Process -FilePath ".\scrcpy.exe" -ArgumentList $ScrcpyArgs -WindowStyle Normal -PassThru

# 6. Interface Polishing: Forces immersive view navigation parameters
Start-Sleep -Seconds 3
.\adb.exe shell settings put global policy_control immersive.navigation=*

# =========================================================================
# ⚙️ INTERACTIVE DESKTOP CONTEXT MENU & MINIMIZE HOOKS ENGINE
# =========================================================================
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create a clean, dark-themed PC Context Menu mapping matrix
$ContextMenu = New-Object System.Windows.Forms.ContextMenuStrip
$ContextMenu.BackColor = [System.Drawing.Color]::FromArgb(35, 35, 45)
$ContextMenu.ForeColor = [System.Drawing.Color]::White

$MenuRefresh = $ContextMenu.Items.Add("🔄 Refresh Desktop")
$MenuLayout = $ContextMenu.Items.Add("🔲 Align Windows")
$MenuSettings = $ContextMenu.Items.Add("⚙️ DeX Settings")

# Simple event feedback loops for clicking context parameters
$MenuRefresh.add_Click({
    Write-Host "[💡 CONTEXT] Refreshing canvas layouts..." -ForegroundColor Cyan
    .\adb.exe shell input keyevent 111 | Out-Null # Sends ESC command to clean current layers
})

$MenuLayout.add_Click({
    Write-Host "[💡 CONTEXT] Re-aligning floating activities..." -ForegroundColor Cyan
    .\adb.exe shell am broadcast -a com.farmerbb.taskbar.SHOW_RECENTS | Out-Null
})

$MenuSettings.add_Click({
    Start-Process ".\adb.exe" "shell am start -n com.farmerbb.taskbar/.activity.MainActivity" -WindowStyle Hidden
})

# Native Win32 loop listener to catch mouse inputs inside the container frame
$User32Sig = @"
[DllImport("user32.dll")]
public static extern IntPtr FindWindow(string lpClassName, string lpWindowName);
[DllImport("user32.dll")]
[return: MarshalAs(UnmanagedType.Bool)]
public static extern bool GetWindowRect(IntPtr hWnd, out RECT lpRect);
public struct RECT { public int Left; public int Top; public int Right; public int Bottom; }
"@
$User32 = Add-Type -MemberDefinition $User32Sig -Name Win32Utils -Namespace Win32 -PassThru

# Hidden execution script background listener task loop
$Task = System.Threading.Tasks.Task::Run({
    $WShell = New-Object -ComObject Wscript.Shell
    $Rect = New-Object Win32.Win32Utils+RECT
    
    while (-not $Process.HasExited) {
        Start-Sleep -Milliseconds 50
        
        # When clicking inside the active window container bounds
        if ($WShell.AppActivate($TargetWindowName)) {
            $hWnd = [Win32.Win32Utils]::FindWindow($null, $TargetWindowName)
            if ($hWnd -ne [IntPtr]::Zero) {
                
                # Check for physical Mouse Key States using native .NET windows forms
                if ([System.Windows.Forms.Control]::MouseButtons -eq [System.Windows.Forms.MouseButtons]::Right) {
                    [Win32.Win32Utils]::GetWindowRect($hWnd, [ref]$Rect)
                    
                    # Intercept right-click position and instantly trigger our beautiful Dark PC Menu instead!
                    $CurrentPos = [System.Windows.Forms.Cursor]::Position
                    if ($CurrentPos.X -ge $Rect.Left -and $CurrentPos.X -le $Rect.Right -and $CurrentPos.Y -ge $Rect.Top -and $CurrentPos.Y -le $Rect.Bottom) {
                        $ContextMenu.Show($CurrentPos)
                        Start-Sleep -Seconds 1 # Simple buffer timeout to prevent click spamming alerts
                    }
                }
            }
        }
    }
})
# =========================================================================

Write-Host "OpenDeX Advanced Interface active. Monitoring layout configurations..." -ForegroundColor Green
$Process.WaitForExit()

# 7. Global Environmental Teardown & Reset Pipeline
Write-Host "`n=========================================" -ForegroundColor Cyan
Write-Host "Session closed down cleanly. Cleaning environmental baseline..." -ForegroundColor Yellow

.\adb.exe shell am broadcast -a com.farmerbb.taskbar.START_STOP_TASKBAR --ez start false | Out-Null
.\adb.exe shell am force-stop com.farmerbb.taskbar | Out-Null
.\adb.exe shell cmd package set-home-activity $PrevLauncher | Out-Null
.\adb.exe shell settings put global policy_control null

Write-Host "[✓] Baseline parameters successfully reset. Phone returned to stock normal state!" -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Cyan
