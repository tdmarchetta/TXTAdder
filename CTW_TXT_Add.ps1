# TXTAdder
# PowerShell To Adding TXT record with Certify the Web
# Version 1.0.5
# Author: Taylor D. Marchetta
# Huge thanks to Kyle Grey.

# String(s) from the BAT file.
param (
    [string]$zone,  #Domain Name
    [string]$id,    #Let's Encrypt nodeName - _acme-challenge.yourdomain.com
    [string]$value  #HashValue from Let's Encrypt
    )

# Variables
$TXTAdder = "C:\TXTAdder\"

# Force the use of TLS 1.2    
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Check for 'C:\TXTAdder\DynuAPIKey.txt' file.
if (Test-Path C:\TXTAdder\DynuAPIKey.txt) {

    # Removes "IX HashValue" in wildcards.
    $zone = $zone -replace "'\*.',"

    # Gets the API Key from the file "DynuAPIKey.txt".
    $memSecurestring = Get-Content  -Path "$TXTAdder\DynuAPIKey.txt" | ConvertTo-SecureString

    $cleartextAPIKey = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR((($memSecurestring))))

    # GET Request to Dynu.com - This will get the ID of the domain.
    $getDomaindata = Invoke-RestMethod -Method GET -Uri ‘https://api.dynu.com/v2/dns/’ -ContentType ‘application/json’ -Headers @{ “Api-Key” = $cleartextAPIKey }

    # This is looking for the object domain "ID".
    $domainID = $getDomaindata.domains.Where({ $_.name -eq $zone }).id

    # Json data for Dynu API.
    $jsonbody = ConvertTo-Json @{

        domainId           = $domainID
        domainName         = $id # _acme-challenge.yourdomain.com
        nodeName           = "_acme-challenge"
        recordType         = "TXT"
        ttl                = "60"
        state              = "true"
        textData           = $value #HashValue from Let's Encrypt

}

    # POST TXT record to Dynu Record.
    Invoke-RestMethod -Method POST -Uri "https://api.dynu.com/v2/dns/$($domainID)/record" -ContentType ‘application/json’ -Headers @{ “Api-Key” = $APIKey } -Body $jsonbody

}
else
{

    Write-Host "API Key file not found. Please re-run or run 'Setup.ps1' as administrator"
    exit

}