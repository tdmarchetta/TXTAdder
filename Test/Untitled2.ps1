$path = "C:\Passwords\pwd.txt"
Add-Type -AssemblyName System.Security
$protected = [System.Security.Cryptography.ProtectedData]::Protect($path, $null, $scope)
$unprotected = [System.Security.Cryptography.ProtectedData]::Unprotect($protected, $null, $scope)
$text = [System.Text.Encoding]::UTF8.GetString($unprotected)
Write-Output $text