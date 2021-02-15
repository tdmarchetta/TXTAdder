# PowerShell To Setting up Scripts to talk to Certify The Web & Dynu.
# Version 1.0.7
# Author: Taylor D. Marchetta

# Variables
$currentlocation = Get-Location
$TXTAdder = "C:\TXTAdder\"

# Check for 'C:\TXTAdder' folder.
# '.trim' will remove leading and trailing spaces and leading and trailing line breaks
if (!(test-path $TXTAdder.trim())) {

    # Makes new folder for TXTAdder: C:\TXTAdder
    New-Item -Path "$TXTAdder" -ItemType Directory
}

# Copy file(s) from the location where "Setup.ps1" is at.
Copy-Item -Path "$currentlocation\CTW_*" -Destination "$TXTAdder" -Recurse -Force

# $getAPIKey | Add-Content -Path - PowerShell will ask for the Dynu API Key.
$getAPIKey = Read-Host -Prompt 'Dynu API Key, Please'

$secureString = $getAPIKey | ConvertTo-SecureString -AsPlainText -Force

# Get content of the string # Save Content to file
$secureString = Convert-FromSecureString | Set-Content -Path "$TXTAdder\DynuAPIKey.txt"

# These PowerShell scripts are not signed...
Set-ExecutionPolicy Bypass

# Unblock all files in TXTAdder
Get-ChildItem $TXTAdder | Unblock-File