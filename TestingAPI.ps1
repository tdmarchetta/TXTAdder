$File = "C:\TXTAdder\DynuAPIKey.txt"

$Password = "Password" | ConvertTo-SecureString -AsPlainText -Force

$Password | ConvertFrom-SecureString | Out-File $File