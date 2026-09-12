# Galaxy-M-Desktop 🚀

An automated PowerShell utility designed to force a standalone, persistent landscape Android desktop environment out of budget Samsung Galaxy M-series and A-series devices via scrcpy virtual display density scaling.

## 🛠️ Prerequisites

Before running the script, make sure your device environment is configured:
1. **Developer Options Enabled** on your Samsung phone (Tap *Build Number* 7 times in software settings).
2. **USB Debugging** toggled ON in Developer Options.
3. **Enable freeform windows** and **Force activities to be resizable** toggled ON in Developer Options.
4. Download the latest version of [scrcpy](https://github.com) for Windows.
5. Launch the Google Play Store on your phone and install **Taskbar (by farmerbb)**. Inside the Taskbar app settings, ensure **Freeform window support** is turned ON.

## 📦 Local Workspace Layout

Place the script file directly inside your extracted scrcpy environment folder:
```text
C:\YourFolder\scrcpy-win64\
  ├── adb.exe
  ├── scrcpy.exe
  └── Launch-Desktop.ps1  <-- Paste this script right here!
```

## 🚀 How to Launch

1. Connect your Samsung device to your Windows 11 PC using a high-quality USB data sync cable.
2. Ensure your phone screen is unlocked.
3. Open a PowerShell terminal window inside the project directory.
4. Execute the deployment engine script:
   ```powershell
   .\Launch-Desktop.ps1
   ```
5. Click **Allow USB Debugging** on your phone display if prompted.

## 🎮 Desktop Canvas Shortcuts
* **Left-Click + Drag:** Interacts with apps, grabs layouts, and repositions windows.
* **Right-Click:** Simulates the hardware *Back* event.
* **Middle-Click (Scroll Wheel):** Simulates the hardware *Home* event.
* **Ctrl + Alt + F:** Toggles borderless Full-Screen Mode to completely hide the host PC taskbar.
