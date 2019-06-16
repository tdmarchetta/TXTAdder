# PowerShell To Setting up Scripts to talk to Certify The Web.
# Author: Taylor D. Marchetta

$currentlocation = Get-Location
New-Item -Path "C:\" -Name "TXTAdder" -ItemType "directory"

# Copy file(s) from the location where "Setup.ps1" is at.
Copy-Item -Path "$currentlocation\CTW_TXT_Add.bat" -Destination 'C:\TXTAdder\'
Copy-Item -Path "$currentlocation\CTW_TXT_Add.ps1" -Destination 'C:\TXTAdder\'
Copy-Item -Path "$currentlocation\CTW_TXT_Delete.bat" -Destination 'C:\TXTAdder\'
Copy-Item -Path "$currentlocation\CTW_TXT_Delete.ps1" -Destination 'C:\TXTAdder\'

###### Gets the API Key from the User.
$getAPIKey = Read-Host -Prompt 'Dynu API Key, Please'
$getAPIKey | Add-Content -Path "C:\TXTAdder\DynuAPIKey.txt"

###### These PowerShell scripts are not signed...
Set-ExecutionPolicy Bypass

# Unblock all files in TXTAdder
dir C:\TXTAdder\ | Unblock-File