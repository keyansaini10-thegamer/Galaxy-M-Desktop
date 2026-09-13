# Galaxy-M-Desktop Framework v17.4 by Keyan Saini
$CurrentVersion = "17.4"
Clear-Host
Write-Host "💥 GALAXY M/F-SERIES OPEN-DEX v$CurrentVersion 💥" -ForegroundColor Yellow
Write-Host "⚙️ Created By Keyan Saini ⚙️" -ForegroundColor Green

# 1. Check Files & Device
if (-not (Test-Path ".\scrcpy.exe") -or -not (Test-Path ".\adb.exe")) {
    Write-Host "[❌ ERROR] Core files missing!" -ForegroundColor Red
    Exit
}
$Devices = .\adb.exe devices | Where-Object { $_ -match '\bdevice\b' }
if (-not $Devices) { 
    Write-Host "[❌ ERROR] Device link failed!" -ForegroundColor Red
    Exit 
}

# 2. Automated Desktop Shortcut Engine
$Desk = [Environment]::GetFolderPath("Desktop")
$Lnk = Join-Path $Desk "Launch OpenDeX Workspace.lnk"
if (-not (Test-Path $Lnk)) {
    try {
        $Wsh = New-Object -ComObject WScript.Shell
        $S = $Wsh.CreateShortcut($Lnk)
        $S.TargetPath = "powershell.exe"
        $S.Arguments = "-NoProfile -ExecutionPolicy Bypass -WindowStyle Minimized -File `"$($MyInvocation.MyCommand.Path)`""
        $S.WorkingDirectory = $PSScriptRoot
        $S.IconLocation = "shell32.dll, 15"
        $S.WindowStyle = 7
        $S.Save()
        Write-Host "[✓] Desktop shortcut created!" -ForegroundColor Green
    } catch { 
        Write-Host "[⚠️] Shortcut failed." -ForegroundColor DarkGray 
    }
}

# 3. Environment & Taskbar Automation
$App = .\adb.exe shell pm list packages com.farmerbb.taskbar
$Free = .\adb.exe shell settings get global enable_freeform_support
if (-not $App -or $Free -ne "1") {
    if (-not $App) {
        if (-not (Test-Path ".\Taskbar.apk")) { 
            Write-Host "[❌] Taskbar.apk missing!" -ForegroundColor Red
            Exit 
        }
        .\adb.exe install -r -g ".\Taskbar.apk" | Out-Null
        Start-Sleep -Sec 3
    }
    .\adb.exe shell pm grant com.farmerbb.taskbar android.permission.WRITE_SECURE_SETTINGS | Out-Null
    .\adb.exe shell settings put global enable_freeform_support 1 | Out-Null
    .\adb.exe shell settings put global force_resizable_activities 1 | Out-Null
}

# 4. Start Desktop Environment
.\adb.exe shell cmd package set-home-activity com.farmerbb.taskbar/.activity.MainActivity | Out-Null
.\adb.exe shell am broadcast -a com.farmerbb.taskbar.START_STOP_TASKBAR --ez start true | Out-Null
Start-Sleep -Sec 1

# 5. Launch Widescreen Display Layer
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

# 6. Automated Teardown Reset
Write-Host "`n=========================================" -ForegroundColor Cyan
Write-Host "Session closed down cleanly. Restoring system profile..." -ForegroundColor Yellow

.\adb.exe shell am broadcast -a com.farmerbb.taskbar.START_STOP_TASKBAR --ez start false | Out-Null
.\adb.exe shell am force-stop com.farmerbb.taskbar | Out-Null
.\adb.exe shell cmd package set-home-activity com.sec.android.app.launcher/.Launcher | Out-Null
.\adb.exe shell settings put global policy_control null | Out-Null

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "[✓] Samsung One UI Restored!" -ForegroundColor Green
