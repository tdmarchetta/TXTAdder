$TXTAdder = "C:\TXTAdder\"
Read-Host -Prompt 'Dynu API Key, Please' |  ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString |  Set-Content -Path "$TXTAdder\DynuAPIKey.txt"
$secretStuff = Get-Content  -Path "$TXTAdder\DynuAPIKey.txt" | ConvertTo-SecureString
[Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR((($secretStuff))))
# | Write-Output