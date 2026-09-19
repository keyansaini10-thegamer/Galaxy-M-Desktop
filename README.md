# 💥 Galaxy-M-Desktop: OpenDeX Workspace Launcher v17.5 💥
> Premium, zero-click Samsung DeX desktop simulation for One UI Core devices!

Created by **Keyan Saini** 🛠️  
Featured on the [r/SamsungDex Reddit Community](https://reddit.com)! 🎉

---

## 🌟 What is Galaxy-M-Desktop?
Samsung restricts their official **DeX Mode** on budget and mid-range devices (like the Galaxy M and F series). **Galaxy-M-Desktop** breaks through those limits! 

Using an automated PowerShell ADB pipeline and the powerful `scrcpy` engine, this framework provisions a gorgeous, high-definition 1080p virtual desktop display layer right from your computer.

---

## 🔥 New Features in v17.5 (Fully Automated Configuration)

* **⚙️ Zero-Click Preference Injection:** **NEW!** No more setting up the mobile desktop manually. The script automatically injects pre-configured interface preferences (`com.farmerbb.taskbar_preferences.xml`) directly into the phone's app directory.
* **⚡ Automated Run-Once Shortcut Maker:** Creates a customized Windows Desktop shortcut during your first execution so you can launch OpenDeX later in one single click.
* **🤫 Minimized Execution Engine:** The behind-the-scenes PowerShell scripts run completely minimized in the Windows taskbar, giving you a clean, clutter-free workstation screen.
* **🤖 Smart Setup Auto-Configuration:** Automatically audits your phone, installs required background components, and grants structural system settings (`WRITE_SECURE_SETTINGS`) over ADB without crashing.
* **🖥️ Immersive 1080p Desktop Canvas:** Configures custom `scrcpy` parameters locked at a fluid 60 FPS with sharp text alignment rendering.
* **🔄 Zero-Trace Automated Teardown:** The moment you close the desktop window, the script automatically cleans up your background settings and safely restores your phone back to stock Samsung One UI.

---

## 📋 Prerequisites & Requirements

Before executing, make sure you have prepared the following parameters:
1. **Windows PC** with PowerShell enabled.
2. **Developer Options** activated on your Samsung phone with **USB Debugging** toggled ON.
3. This script **must** be placed directly inside your local `scrcpy` folder (alongside `scrcpy.exe` and `adb.exe`).
4. Ensure the `Taskbar.apk` and `com.farmerbb.taskbar_preferences.xml` files are in the folder for full automation.

---

## 🚀 Easy Installation & Launch

1. Download or clone this repository into your local `scrcpy` directory.
2. Connect your Samsung smartphone to your PC via a USB cable.
3. Right-click `Launch-Desktop.ps1` and select **Run with PowerShell**.
4. Allow the automatic environment audit to complete. A handy launch icon will appear on your Windows desktop for future sessions!

---

## 🌐 Community & Technical Support
Join the global discussion, share your custom interface setups, and get technical help on our official community platforms:

* **XDA Developers Thread:** [Galaxy-M-Desktop Forum Hub](https://xdaforums.com/t/script-open-source-galaxy-m-desktop-v17-5-automated-1080p-dex-simulation-for-one-ui-core.4802071/) — Drop a comment, share your device model, or troubleshoot connection hurdles with the community.
* **Bug Reports & Feature Requests:** Please use the official [GitHub Issues](https://github.com/keyansaini10-thegamer/Galaxy-M-Desktop/issues) tab here on the repository to report any automated shell script execution crashes.

---

## 🤝 Contributing & Feedback
Got suggestions or want to report bugs? Check out the active community discussions on our official **[Reddit Thread]([https://reddit.com](https://www.reddit.com/r/SamsungDex/comments/1wkjdx8/i_am_10_years_old_and_i_coded_a_powershell/))**! Feel free to fork this project, open an issue, or submit a pull request to make budget desktop workflows even better.

A special thank you to the developers of scrcpy and Taskbar!
