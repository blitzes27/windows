# Registers the device directly into Autopilot (no CSV).
# NOTE: Run PowerShell as administrator. You'll be prompted to sign in.

Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
Install-Script Get-WindowsAutopilotInfo -Force

# Set Gouptag!
Get-WindowsAutopilotInfo -Online -GroupTag "MyGroupTag"