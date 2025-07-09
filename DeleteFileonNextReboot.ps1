# ============================
# PowerShell: Delete File on Next Reboot
# ============================

# ==== CONFIGURATION ====
# Full path to the file you want to delete
$fileToDelete = "C:\Path\To\File.txt"

# ==== CHECK IF FILE EXISTS ====
if (-Not (Test-Path $fileToDelete)) {
    Write-Host "File does not exist: $fileToDelete"
    return
}

# ==== PREPARE DELETE ENTRY ====
# Convert path to the required null-terminated string format
$deleteEntry = "\\??\\" + $fileToDelete + "`0" + "`0"

# ==== READ EXISTING ENTRIES ====
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager"
$existing = (Get-ItemProperty -Path $regPath -Name "PendingFileRenameOperations" -ErrorAction SilentlyContinue).PendingFileRenameOperations

# Convert to array if not null
if ($existing) {
    $newValue = @($existing + $deleteEntry)
} else {
    $newValue = @($deleteEntry)
}

# ==== SET THE REGISTRY VALUE ====
Set-ItemProperty -Path $regPath -Name "PendingFileRenameOperations" -Value $newValue

Write-Host "Scheduled deletion of: $fileToDelete on next reboot."
