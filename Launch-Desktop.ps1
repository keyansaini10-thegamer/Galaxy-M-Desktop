# Galaxy-M-Desktop Framework v18.0 by Keyan Saini
$CurrentVersion = "18.0"
Clear-Host
Write-Host "💥 GALAXY M/F-SERIES OPEN-DEX v$CurrentVersion 💥" -ForegroundColor Yellow
Write-Host "⚙️ Created By Keyan Saini ⚙️" -ForegroundColor Green

# 1. Check Files & Device
if (-not (Test-Path ".\scrcpy.exe") -or -not (Test-Path ".\adb.exe")) {
    Write-Host "[X ERROR] Core files missing!" -ForegroundColor Red
    Exit
}
$Devices = .\adb.exe devices | Where-Object { $_ -match '\bdevice\b' }
if (-not $Devices) { 
    Write-Host "[X ERROR] Device link failed!" -ForegroundColor Red
    Exit 
}

# 2. Automated Desktop Shortcut Engine
$Desk = [Environment]::GetFolderPath("Desktop")
$Lnk = Join-Path $Desk "Launch OpenDeX Workspace.lnk"
if (-not (Test-Path $Lnk)) {
    try {
        $Wsh = New-Object -ComObject WScript.Shell
        $Shortcut = $Wsh.CreateShortcut($Lnk)
        $Shortcut.TargetPath = "powershell.exe"
        $ScriptPath = $MyInvocation.MyCommand.Path
        $Shortcut.Arguments = "-NoProfile -ExecutionPolicy Bypass -WindowStyle Minimized -File `"$ScriptPath`""
        $Shortcut.WorkingDirectory = $PSScriptRoot
        $Shortcut.IconLocation = "shell32.dll, 15"
        $Shortcut.WindowStyle = 7 
        $Shortcut.Save()
        Write-Host "[OK] Desktop shortcut successfully created!" -ForegroundColor Green
    } catch { 
        Write-Host "[!] Shortcut creation failed." -ForegroundColor DarkGray 
    }
}

# 3. Environment & Taskbar Auto-Installer
$App = .\adb.exe shell pm list packages com.farmerbb.taskbar
$Free = .\adb.exe shell settings get global enable_freeform_support

if (-not $App -or $Free -ne "1") {
    if (-not $App) {
        if (-not (Test-Path ".\Taskbar.apk")) { 
            Write-Host "[X] Taskbar.apk missing!" -ForegroundColor Red
            Exit 
        }
        Write-Host "-> Automatically installing Taskbar application..." -ForegroundColor Cyan
        .\adb.exe install -r -g ".\Taskbar.apk" | Out-Null
        Start-Sleep -Seconds 3
    }
    .\adb.exe shell pm grant com.farmerbb.taskbar android.permission.WRITE_SECURE_SETTINGS | Out-Null
    .\adb.exe shell settings put global enable_freeform_support 1 | Out-Null
    .\adb.exe shell settings put global force_resizable_activities 1 | Out-Null
}

# 4. Automated Preference Injection
if (Test-Path ".\com.farmerbb.taskbar_preferences.xml") {
    Write-Host "-> Injecting pre-configured OpenDeX interface settings..." -ForegroundColor Cyan
    .\adb.exe push ".\com.farmerbb.taskbar_preferences.xml" "/data/local/tmp/prefs.xml" | Out-Null
    .\adb.exe shell "run-as com.farmerbb.taskbar cp /data/local/tmp/prefs.xml /data/data/com.farmerbb.taskbar/shared_prefs/com.farmerbb.taskbar_preferences.xml" 2>$null
    .\adb.exe shell "run-as com.farmerbb.taskbar chmod 660 /data/data/com.farmerbb.taskbar/shared_prefs/com.farmerbb.taskbar_preferences.xml" 2>$null
    .\adb.exe shell "rm /data/local/tmp/prefs.xml" | Out-Null
} else {
    Write-Host "[!] Preference template missing. Running with defaults." -ForegroundColor DarkGray
}

# 5. Start Desktop Environment & Hide Navigation Buttons
Write-Host "-> Activating desktop home workspace..." -ForegroundColor Yellow
.\adb.exe shell cmd package set-home-activity com.farmerbb.taskbar/.activity.MainActivity | Out-Null
.\adb.exe shell am broadcast -a com.farmerbb.taskbar.START_STOP_TASKBAR --ez start true | Out-Null
.\adb.exe shell settings put global policy_control immersive.navigation=*
Start-Sleep -Seconds 1

# 6. Launch Widescreen Display Layer
$Args = @(
    "--new-display=1920x1080/160",
    "--max-fps=60",
    "--video-bit-rate=16M",
    "--render-driver=direct3d11",
    "--window-title=OpenDeX-Workspace",
    "--shortcut-mod=lctrl,lalt",
    "--always-on-top"
)
Start-Process -FilePath ".\scrcpy.exe" -ArgumentList $Args -WindowStyle Normal -Wait

# 7. Automated Teardown & Reset Navigation Buttons to Default
Write-Host "`n=========================================" -ForegroundColor Cyan
Write-Host "Session closed down cleanly. Restoring system profile..." -ForegroundColor Yellow

.\adb.exe shell am broadcast -a com.farmerbb.taskbar.START_STOP_TASKBAR --ez start false | Out-Null
.\adb.exe shell am force-stop com.farmerbb.taskbar | Out-Null
.\adb.exe shell cmd package set-home-activity com.sec.android.app.launcher/.Launcher | Out-Null
.\adb.exe shell settings put global policy_control null

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "[OK] Samsung One UI Restored!" -ForegroundColor Green
