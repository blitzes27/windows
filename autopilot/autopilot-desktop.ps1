# Collects the Autopilot hardware hash and saves it as a CSV on the desktop.
# NOTE: Run PowerShell as administrator.

Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
Install-Script Get-WindowsAutopilotInfo -Force
Get-WindowsAutopilotInfo -OutputFile "$env:USERPROFILE\Desktop\AutopilotHWID.csv"