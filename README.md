# 💥 Galaxy-M-Desktop: OpenDeX Workspace Launcher v17.4 💥
> Bring the premium Samsung DeX desktop experience to Galaxy M-Series & F-Series smartphones!

Created by **Keyan Saini** 🛠️  
Featured on the [r/SamsungDex Reddit Community](https://reddit.com)! 🎉

---

## 🌟 What is Galaxy-M-Desktop?
Samsung restricts their official **DeX Mode** on budget and mid-range One UI Core devices (like the Galaxy M and F series). **Galaxy-M-Desktop** breaks through those limits! 

Using an automated PowerShell ADB pipeline and the powerful `scrcpy` engine, this framework provisions a gorgeous, high-definition 1080p virtual desktop display layer right from your computer.

---

## 🔥 Key Features in v17.4

* **⚡ Automated Run-Once Shortcut Maker:** Creates a customized Windows Desktop shortcut during your first execution so you can launch OpenDeX later in one single click.
* **🤫 Minimized Execution Engine:** The behind-the-scenes PowerShell scripts run completely minimized in the Windows taskbar, giving you a clean, clutter-free workstation screen.
* **🤖 Smart Setup Auto-Configuration:** Automatically audits your phone, downloads required background components if missing, and grants structural system settings (`WRITE_SECURE_SETTINGS`) over ADB without crashing.
* **🖥️ Immersive 1080p Desktop Canvas:** Configures custom `scrcpy` parameters locked at a fluid 60 FPS with sharp text alignment rendering.
* **🔄 Zero-Trace Automated Teardown:** The moment you close the desktop window, the script automatically cleans up your background settings and safely restores your phone back to stock Samsung One UI.

---

## 📋 Prerequisites & Requirements

Before executing, make sure you have prepared the following parameters:
1. **Windows PC** with PowerShell enabled.
2. **Developer Options** activated on your Samsung phone with **USB Debugging** toggled ON.
3. This script **must** be placed directly inside your local `scrcpy` folder (alongside `scrcpy.exe` and `adb.exe`).
4. (Optional) Place a copy of `Taskbar.apk` in the same directory for fully automated offline mobile layout deployment.

---

## 🚀 Easy Installation & Launch

1. Download or clone this repository into your local `scrcpy` directory.
2. Connect your Samsung smartphone to your PC via a USB cable.
3. Right-click `Launch-Desktop.ps1` and select **Run with PowerShell**.
4. Allow the automatic environment audit to complete. A handy launch icon will appear on your Windows desktop for future sessions!

---

## 🤝 Contributing & Feedback
Got suggestions or want to report bugs? Check out the active community discussions on our official **[Reddit Thread](https://reddit.com)**! Feel free to fork this project, open an issue, or submit a pull request to make budget desktop workflows even better.
