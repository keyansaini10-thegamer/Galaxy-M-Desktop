# Galaxy-M-Desktop
An automated PowerShell utility designed to force a standalone landscape Android desktop environment out of budget Samsung Galaxy M-series and A-series devices via scrcpy virtual display bridging.
# Galaxy-M-Desktop 

An automated PowerShell utility designed to force a standalone landscape Android desktop environment out of budget Samsung Galaxy M-series and A-series devices via scrcpy virtual display bridging.

## Prerequisites

Before running the script, make sure you have:
1. **Developer Options Enabled** on your Samsung phone.
2. **USB Debugging** toggled ON.
3. **Force desktop mode** and **Enable freeform windows** toggled ON in Developer Options.
4. The latest version of [scrcpy](https://github.com) downloaded and extracted into the same folder as this script.

## How to Run

1. Clone or download this repository into your `scrcpy` folder.
2. Connect your Samsung device to your Windows 11 PC using a high-quality data cable.
3. Open PowerShell in the project directory.
4. Execute the deployment script:
   ```powershell
   .\Launch-Desktop.ps1
   ```
5. Click **Allow USB Debugging** on your phone screen when prompted.

## Desktop Mode Navigation Shortcuts
* **Left-Click + Drag:** Acts like your finger to interact, drag, and open apps.
* **Right-Click:** Back button.
* **Middle-Click (Scroll Wheel):** Home button.
* **Ctrl + Alt + F:** Toggle Full-Screen view.
