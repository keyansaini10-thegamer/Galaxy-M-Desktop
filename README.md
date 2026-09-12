# Galaxy-M-Desktop

An automated PowerShell utility designed to force a standalone, persistent landscape Android desktop environment out of budget Samsung Galaxy M-series and A-series devices via scrcpy virtual display density scaling and OpenDeX optimizations.

## 🚀 Key Features
* **Smart Setup Checker & Auto-Installer:** Automatically detects, installs, and grants permissions for necessary background tools.
* **Widescreen Desktop Shell:** Forces an immersive 1080p landscape canvas at a fluid 60 FPS.
* **Custom Win32 Context Menu:** Intercepts clicks to inject a gorgeous, dark-themed PC desktop right-click menu (Refresh, Align Windows, DeX Settings).
* **Automatic Session Teardown:** Instantly reverts your smartphone safely back to its stock configuration the moment you close the application.

## 📋 Prerequisites

Before running the script, make sure your phone's device environment is configured:

1. **Developer Options Enabled** on your Samsung phone (Tap *Build Number* 7 times in your software settings).
2. **USB Debugging** toggled ON in Developer Options.
3. **Enable freeform windows** and **Force activities to be resizable** toggled ON inside Developer Options.
4. Download the latest version of **scrcpy** for Windows.

## 📂 Local Workspace Layout

Place the `Launch-Desktop.ps1` script file directly inside your extracted scrcpy environment folder like this:

```text
C:\YourFolder\scrcpy-win64\
  ├── adb.exe
  ├── scrcpy.exe
  ├── Taskbar.apk (Optional: for automated script setup)
  └── Launch-Desktop.ps1  <-- Paste this script right here!
```

## 🎮 How to Launch

1. Connect your Samsung device to your Windows PC using a high-quality USB data sync cable.
2. Ensure your phone screen is unlocked.
3. Open a PowerShell terminal window inside your project folder.
4. Execute the deployment script:
   ```powershell
   .\Launch-Desktop.ps1
   ```
5. Click **Allow USB Debugging** on your phone display if prompted.

## ⌨️ Desktop Canvas Shortcuts

* **Left-Click + Drag:** Interacts with apps, grabs layouts, and repositions windows.
* **Right-Click:** Instantly opens the customized PC Context Menu window.
* **Ctrl + Alt + F:** Toggles borderless Full-Screen Mode to completely hide the host PC taskbar.

## 🤝 Contributing & Making It Better!

**Please help me make this project better and better!** 🌟

Whether you want to optimize the PowerShell script, fix a bug, or suggest a cool new customization feature, I would love your support. Feel free to:
* **Open an Issue** if you find something broken.
* **Submit a Pull Request (PR)** with your code improvements.
* **Leave feedback** on how it runs on your specific Samsung model.


Let's build the ultimate budget Android desktop experience together!



I'm too lazy to give you the details so I asked AI to.

