# TXTAdder
# PowerShell To Adding TXT record with Certify the Web
# Version 1.0.2
# Author: Taylor D. Marchetta
# Huge thanks to James Crissman and Kyle Grey.

# String(s) from the BAT file.
param (
    [string]$zone,  #Domain Name
    [string]$id,    #Let's Encrypt nodeName - _acme-challenge.yourdomain.com
    [string]$value  #HashValue for Let's Encrypt
    )

# Check for 'C:\TXTAdder\DynuAPIKey.txt' file.
if (Test-Path C:\TXTAdder\DynuAPIKey.txt) {

# Removes "IX HashValue" in wildcards.
$zone = $zone -replace "'\*.',"

# Gets the API Key from the file "DynuAPIKey.txt".
$APIKey = Get-Content -Path 'C:\TXTAdder\DynuAPIKey.txt'

# GET Request to Dynu.com - This will get the ID of the domain.
$getdomaindata = Invoke-RestMethod -Method GET -Uri ‘https://api.dynu.com/v2/dns/’ -ContentType ‘application/json’ -Headers @{ “Api-Key” = $APIKey }

# This is looking for the object domain "ID".
$domainid = $getdomaindata.domains.Where({ $_.name -eq $zone }).id

# Json data for Dynu API.
$jsonbody = ConvertTo-Json @{

    domainId           = $domainid
    domainName         = $id # _acme-challenge.yourdomain.com
    nodeName           = "_acme-challenge"
    recordType         = "TXT"
    ttl                = "60"
    state              = "true"
    textData           = $value

} # End Json data for Dynu API.

# POST TXT record to Dynu Record.
Invoke-RestMethod -Method POST -Uri "https://api.dynu.com/v2/dns/$($domainid)/record" -ContentType ‘application/json’ -Headers @{ “Api-Key” = $APIKey } -Body $jsonbody

} # End "if"
else
{

Write-Host "API Key file not found. Please re-run or run 'Setup.ps1' as administrator"
exit

} # End "else"