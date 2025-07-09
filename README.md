# PowerShell Script: Delete File on Next Reboot

This PowerShell script schedules a file for deletion on the next system reboot by modifying the Windows Registry key `PendingFileRenameOperations`.

## 📝 Description

Windows allows certain files to be deleted on reboot if they are locked or in use. This script adds the target file to the appropriate registry value so that it is deleted before the next Windows startup.

## 📂 File

- `DeleteFileonNextReboot.ps1`: The main PowerShell script.

## ⚙️ How It Works

The script:
1. Verifies the file exists.
2. Converts the file path to a format compatible with the Windows Session Manager.
3. Appends the file path (in delete mode) to the `PendingFileRenameOperations` registry key.
4. Upon reboot, Windows deletes the file.

## 🖥️ Usage

1. Open PowerShell as Administrator.
2. Modify the script to set the correct file path:
   ```powershell
   $fileToDelete = "C:\Path\To\File.txt"
3. Run `DeleteFileonNextReboot.ps1` as admin
4. Reboot System

## 🛑 Requirements

Windows OS

Administrator privileges (required to modify the registry)

PowerShell 5.1 or later

## 📁 Registry Details
The script modifies the following registry value:

```
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\PendingFileRenameOperations
```

Each entry is a pair of strings:

Source path with \\??\\ prefix

Null destination string ("") indicates deletion

## ⚠️ Warnings

Use caution when modifying the registry.

Ensure the file path is correct to avoid unintended deletions.

Back up your registry before running the script in production environments.

This script is provided as-is without warranty. Use at your own risk.

## ✅ Example Output

Scheduled deletion of: C:\Path\To\File.txt on next reboot.



