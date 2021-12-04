# PowerShell To Setting up Scripts to talk to Certify The Web & Dynu.
# Version 1.0.7
# Author: Taylor D. Marchetta

# Variables
$currentlocation = Get-Location
$TXTAdder = "C:\TXTAdder\"

#Install Module
Install-Module -Name CredentialManager
Import-Module CredentialManager

#Get API key and Stored in Credential Manager
$DynuAPIKey = Read-Host -Prompt "Enter the API key"
New-StoredCredential -Target DynuAPIKey -Persist LOCALMACHINE -Comment 'Dynu API Key for Certify the Web.' -Type Generic -UserName '' -Password $DynuAPIKey

# Check for 'C:\TXTAdder' folder.
# '.trim' will remove leading and trailing spaces and leading and trailing line breaks
if (!(test-path $TXTAdder.trim())) {

    # Makes new folder for TXTAdder: C:\TXTAdder
    New-Item -Path "$TXTAdder" -ItemType Directory
}

# Copy file(s) from the location where "Setup.ps1" is at.
Copy-Item -Path "$currentlocation\CTW_*" -Destination "$TXTAdder" -Recurse -Force

# These PowerShell scripts are not signed...
Set-ExecutionPolicy Bypass

# Unblock all files in TXTAdder
Get-ChildItem 'C:\TXTAdder\' | Unblock-File