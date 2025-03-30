<#
.SYNOPSIS
    Creates a secure folder
.DESCRIPTION
    - Works on both English and Swedish systems
    - Assigns SYSTEM and Administrators full control
    - Assigns Users read & execute
.NOTES
    Run as Administrator
#>

# Check if script is run as Administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "This script must be run as Administrator."
    exit
}

# Define the folder path
$folderPath = "C:\Path\NameOfYourFolder"

# Create folder if it does not exist
if (-not (Test-Path $folderPath)) {
    New-Item -ItemType Directory -Path $folderPath -Force | Out-Null
    Write-Host "Folder created: $folderPath"
} else {
    Write-Host "Folder already exists: $folderPath"
}

# Get the current ACL
$acl = Get-Acl $folderPath

# Clear all existing rules
$acl.SetAccessRuleProtection($true, $false)  # Disable inheritance and remove existing rules

# Define rights
$rightsFull = [System.Security.AccessControl.FileSystemRights]::FullControl
$rightsRead = [System.Security.AccessControl.FileSystemRights]::ReadAndExecute

# Inheritance flags
$inherit = [System.Security.AccessControl.InheritanceFlags]::ContainerInherit, [System.Security.AccessControl.InheritanceFlags]::ObjectInherit
$propagation = [System.Security.AccessControl.PropagationFlags]::None

# Define identity references using SID
$systemUser = New-Object System.Security.Principal.SecurityIdentifier("S-1-5-18") # SYSTEM
$admins = New-Object System.Security.Principal.SecurityIdentifier("S-1-5-32-544") # Administrators
$users = New-Object System.Security.Principal.SecurityIdentifier("S-1-5-32-545") # Users

# Add access rules
$acl.AddAccessRule((New-Object System.Security.AccessControl.FileSystemAccessRule($systemUser, $rightsFull, $inherit, $propagation, "Allow")))
$acl.AddAccessRule((New-Object System.Security.AccessControl.FileSystemAccessRule($admins, $rightsFull, $inherit, $propagation, "Allow")))
$acl.AddAccessRule((New-Object System.Security.AccessControl.FileSystemAccessRule($users, $rightsRead, $inherit, $propagation, "Allow")))

# Apply ACL with error handling
try {
    Set-Acl -Path $folderPath -AclObject $acl
    Write-Host "Permissions successfully set."
} catch {
    Write-Host "Failed to set permissions: $($_.Exception.Message)"
}