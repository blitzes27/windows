# Define the script content for baby_script.ps1
$ScriptContent = @'

# script content starts here

<#
.SYNOPSIS
  Enables Windows Firewall for Domain, Private, and Public profiles.
#>

Write-Host "Enabling Windows Firewall for Domain, Private, and Public profiles..."
Set-NetFirewallProfile -Profile Domain,Private,Public -Enabled True
Write-Host "Windows Firewall enabled successfully."

# script content ends here

'@

# Define the script file path
$ScriptFilePath = Join-Path -Path $folderPath -ChildPath "baby_script.ps1"

# Create or replace the baby_script.ps1 script file
try {
    Set-Content -Path $ScriptFilePath -Value $ScriptContent -Force
    Write-Host "Script file created or replaced: $ScriptFilePath"
} catch {
    Write-Host "Failed to create or replace script file: $($_.Exception.Message)"
}