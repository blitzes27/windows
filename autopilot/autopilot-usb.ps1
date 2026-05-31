# autopilot-usb.ps1
# Run from OOBE: Shift+F10 -> type powershell -> go to the USB -> .\autopilot-usb.ps1
# Collects the hardware hash into a CSV on the same USB. -Append adds to the same
# file so you can run it on several machines one after another.

Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force

# Folder where this script lives, i.e. the USB
$Root = $PSScriptRoot

# Remove any "downloaded from the internet" flag so the script is allowed to run
Unblock-File -Path "$Root\Get-WindowsAutopilotInfo.ps1" -ErrorAction SilentlyContinue

# Collect the hash and append it to the CSV on the USB
& "$Root\Get-WindowsAutopilotInfo.ps1" -OutputFile "$Root\AutopilotHWID.csv" -Append

Write-Host "Done. Hash saved to $Root\AutopilotHWID.csv" -ForegroundColor Green